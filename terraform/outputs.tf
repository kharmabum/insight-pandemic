output "kafka_zookeeper_0_dns" {
  value = "${aws_eip.elastic_ips_kafka.0.public_dns}"
}

output "kafka_zookeeper_1_dns" {
  value = "${aws_eip.elastic_ips_kafka.1.public_dns}"
}


output "kafka_zookeeper_2_dns" {
  value = "${aws_eip.elastic_ips_kafka.2.public_dns}"
}

output "kafka_broker_0_dns" {
  value = "${aws_eip.elastic_ips_kafka.3.public_dns}"
}

output "kafka_broker_1_dns" {
  value = "${aws_eip.elastic_ips_kafka.4.public_dns}"
}

output "kafka_broker_2_dns" {
  value = "${aws_eip.elastic_ips_kafka.5.public_dns}"
}

output "kafka_ksql_dns" {
  value = "${aws_eip.elastic_ip_ksql.public_dns}"
}

output "kafka_connector_dns" {
  value = "${aws_eip.elastic_ip_connector.public_dns}"
}

output "es_kibana_dns" {
  value = "${aws_eip.elastic_ip_es_kibana.public_dns}"
}
