 # output "cluster_size" {
 #    value = "${aws_instance.cluster_master.count + aws_instance.cluster_workers.count}"
 # }

output "example_0_public_ip" {
  value = "${aws_instance.example.0.public_ip}"
}

output "example_1_public_ip" {
  value = "${aws_instance.example.1.public_ip}"
}

# output "app.0.ip" {
#   value = "${aws_instance.app.0.private_ip}"
# }

# output "app.1.ip" {
#   value = "${aws_instance.app.1.private_ip}"
# }
