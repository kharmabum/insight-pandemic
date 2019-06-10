variable "aws_region" {
  description = "AWS region to launch servers."
}


variable "keypair_name" {
  description = "Pre-made key pair name, stored on local machine"
}


variable "fellow_name" {
  description = "Developer's name. Used as prefix."
}


variable "amis" {
  type        = "map"
  description = "Base AMI to launch the instances with"
}


variable "cluster_name" {
  description = "The name for your instances in your cluster"
}


variable "aws_access_key" {
  description = "AWS access key (e.g. ABCDE1F2G3HIJKLMNOP )"
}


variable "aws_secret_key" {
  description = "AWS secret key (e.g. 1abc2d34e/f5ghJKlmnopqSr678stUV/WXYZa12 )"
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
}