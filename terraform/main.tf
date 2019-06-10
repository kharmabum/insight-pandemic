provider "aws" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.aws_region}"
  version     = "~> 2.0"
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
# Data sources
//////////////////////////////////////////////////////////////////////////////////////////////////////


data "aws_availability_zones" "all" {}


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
  enable_s3_endpoint = true

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

module "test_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> v3.0"

  name        = "test-sg"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules        = ["all-all"]

  tags = {
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# Test instances
//////////////////////////////////////////////////////////////////////////////////////////////////////


resource "aws_instance" "example" {
  ami                         = "${lookup(var.amis, var.aws_region)}"
  instance_type               = "t2.micro"
  key_name                    = "${var.keypair_name}"
  count                       = 2
  associate_public_ip_address = true
  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    "${module.default_sg.this_security_group_id}",
    "${module.open_ssh_sg.this_security_group_id}",
    "${module.test_sg.this_security_group_id}"
  ]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              python3 -m http.server 8080 &
              EOF

  root_block_device {
      volume_type = "standard"
      volume_size = 11
  }

  tags = {
    Name = "terraform-example"
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
# Kafka cluster
//////////////////////////////////////////////////////////////////////////////////////////////////////

/* Zookeeper nodes */
resource "aws_instance" "cluster_master" {
  ami             = "${lookup(var.amis, var.aws_region)}"
  instance_type   = "m4.large"
  key_name        = "${var.keypair_name}"
  count           = 1

  vpc_security_group_ids      = ["${module.open_all_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true

  root_block_device {
    volume_size = 100
    volume_type = "standard"
  }

  tags {
    Name        = "${var.cluster_name}-master-${count.index}"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    HadoopRole  = "master"
    SparkRole   = "master"
  }
}

/* Broker nodes */
resource "aws_instance" "cluster_workers" {
  ami             = "${lookup(var.amis, var.aws_region)}"
  instance_type   = "m4.large"
  key_name        = "${var.keypair_name}"
  count           = 3

  vpc_security_group_ids      = ["${module.open_all_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true

  root_block_device {
      volume_size = 7
      volume_type = "standard"
  }

  tags {
    Name        = "${var.cluster_name}-worker-${count.index}"
    Owner       = "${var.fellow_name}"
    Environment = "dev"
    Terraform   = "true"
    HadoopRole  = "worker"
    SparkRole   = "worker"
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
# Elastic IPs & ELB Volumes
//////////////////////////////////////////////////////////////////////////////////////////////////////

resource "aws_eip" "elastic_ips_for_instances" {
  vpc       = true
  instance  = "${element(concat(aws_instance.cluster_master.*.id, aws_instance.cluster_workers.*.id), count.index)}"
  count     = "${aws_instance.cluster_master.count + aws_instance.cluster_workers.count}"
}
