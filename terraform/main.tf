provider "aws" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.aws_region}"
  version     = "~> 2.0"
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
# Data sources, local variables
//////////////////////////////////////////////////////////////////////////////////////////////////////


data "aws_availability_zones" "all" {}

locals {
  kafka_cluster_size = "${var.kafka_zookeeper_count + var.kafka_broker_count}"
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
# VPC
//////////////////////////////////////////////////////////////////////////////////////////////////////


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> v2.0"

  name = "${var.fellow_name}-vpc"

  cidr             = "10.0.0.0/26"
  azs              = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets   = ["10.0.0.0/28"]

  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_s3_endpoint   = true

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# Security groups
//////////////////////////////////////////////////////////////////////////////////////////////////////


module "open_ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> v3.0"

  name        = "ssh-open-sg"
  description = "Security group for SSH and instance configuration, open from/to all IPs. Permits all egress. Only apply temporarily."
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}

module "default_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> v3.0"

  name        = "default-sg"
  description = "Default security group that allows inbound and outbound traffic from all instances in the group"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_self = [{ rule = "all-all" }]
  egress_with_self  = [{ rule = "all-all" }]

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}

module "kafka_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/kafka"
  version = "~> v3.0"

  name        = "kafka_sg"
  description = "Security group for broker nodes. Permits inbound tcp on 9092 and all-all egress."
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["kafka-broker-tcp"]
  egress_rules        = []


  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}

module "control_center_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> v3.0"

  name        = "control-center-sg"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 9021
      to_port     = 9021
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules  = ["all-all"]

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}

module "ksql_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> v3.0"

  name    = "ksql-sg"
  vpc_id  = "${module.vpc.vpc_id}"

  # Inbound tcp traffic to 8088 from anywhere (can restrict to control center or lambda)
  ingress_with_cidr_blocks = [
    {
      from_port   = 8088
      to_port     = 8088
      protocol    = "all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  # Allow all outbound
  egress_rules  = ["all-all"]

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# Elastic IPs & VPC Endpoints
//////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_eip" "elastic_ips_kafka" {
  vpc   = true
  count = "${local.kafka_cluster_size}"
}

resource "aws_eip_association" "eip_assoc_kafka" {
  instance_id   = "${element(concat(aws_instance.zookeeper_nodes.*.id, aws_instance.broker_nodes.*.id), count.index)}"
  allocation_id = "${element(aws_eip.elastic_ips_kafka.*.id, count.index)}"
  count         = "${local.kafka_cluster_size}"
}

resource "aws_eip" "elastic_ip_ksql" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc_ksql" {
  instance_id   = "${aws_instance.ksql_server.id}"
  allocation_id = "${aws_eip.elastic_ip_ksql.id}"
}

resource "aws_eip" "elastic_ip_connector" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc_connector" {
  instance_id   = "${aws_instance.connector_server.id}"
  allocation_id = "${aws_eip.elastic_ip_connector.id}"
}

resource "aws_vpc_endpoint" "vpc_endpoint_s3" {
  vpc_id             = "${module.vpc.vpc_id}"
  service_name       = "com.amazonaws.${var.aws_region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_route_table_association" {
  route_table_id  = "${module.vpc.public_route_table_ids[0]}"
  vpc_endpoint_id = "${aws_vpc_endpoint.vpc_endpoint_s3.id}"
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# KSQL instance
//////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_instance" "ksql_server" {
  ami                         = "${lookup(var.amis, var.aws_region)}"
  instance_type               = "t2.medium"
  key_name                    = "${var.keypair_name}"

  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${module.default_sg.this_security_group_id}",
    "${module.ksql_sg.this_security_group_id}",
    "${module.open_ssh_sg.this_security_group_id}" # remove once configuration completed
  ]

  root_block_device {
      volume_type = "standard"
      volume_size = 10
  }

  tags = {
    Name        = "ksql_server"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    role        = "worker"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# Kafka cluster
//////////////////////////////////////////////////////////////////////////////////////////////////////

/* Zookeeper nodes */
resource "aws_instance" "zookeeper_nodes" {
  ami             = "${lookup(var.amis, var.aws_region)}"
  instance_type   = "t2.medium"
  key_name        = "${var.keypair_name}"
  count           = "${var.kafka_zookeeper_count}"

  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${module.default_sg.this_security_group_id}",
    "${module.kafka_sg.this_security_group_id}",
    "${module.control_center_sg.this_security_group_id}",
    "${module.open_ssh_sg.this_security_group_id}" # remove once configuration completed
  ]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name        = "kafka-zookeeper-${count.index}"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    role        = "zookeeper"
  }
}

/* Broker nodes */
resource "aws_instance" "broker_nodes" {
  ami             = "${lookup(var.amis, var.aws_region)}"
  instance_type   = "t2.large"
  key_name        = "${var.keypair_name}"
  count           = "${var.kafka_broker_count}"

  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${module.default_sg.this_security_group_id}",
    "${module.kafka_sg.this_security_group_id}",
    "${module.control_center_sg.this_security_group_id}",
    "${module.open_ssh_sg.this_security_group_id}" # remove once configuration completed
  ]

  root_block_device {
      volume_size = 250
      volume_type = "gp2"
  }

  tags = {
    Name        = "kafka-broker-${count.index}"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    role        = "broker"
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
# Connector instance
//////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_instance" "connector_server" {
  ami                         = "${lookup(var.amis, var.aws_region)}"
  instance_type               = "t2.medium"
  key_name                    = "${var.keypair_name}"
  iam_instance_profile        = "S3-Sink-EC2-Instance-Profile"

  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${module.default_sg.this_security_group_id}",
    "${module.open_ssh_sg.this_security_group_id}" # remove once configuration completed
  ]

  root_block_device {
      volume_type = "standard"
      volume_size = 10
  }

  tags = {
    Name        = "connector_server"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    role        = "worker"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# S3 buckets
//////////////////////////////////////////////////////////////////////////////////////////////////////

resource "aws_s3_bucket" "insight_pandemic_s3b" {
  bucket = "insight-pandemic" # this must be globally unique
  acl    = "public-read"

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}
