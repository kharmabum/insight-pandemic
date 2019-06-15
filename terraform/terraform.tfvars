aws_region   = "us-west-2"
fellow_name  = "JC-FOUST"
keypair_name = "JC-FOUST-IAM-keypair"

/* Ubuntu 16.04 amis, amd64, hvm:ebs-ssd by region */
amis = {
  us-west-1 = "ami-0c1b880a476bb7b40"
  us-west-2 = "ami-0e63f50857fdc1f9f"
}

kafka_zookeeper_count = 3
kafka_broker_count    = 3