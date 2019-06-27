#!/bin/sh

NAME=$1

curl -X POST 'http://ec2-54-214-145-33.us-west-2.compute.amazonaws.com:8083/connectors'    \
-H 'Content-Type: application/json'     \
-d                                      \
'{
 "name" : "es-sink-$NAME",
 "config" : {
  "connector.class" : "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
  "tasks.max" : "1",
  "topics" : "$NAME",
  "connection.url" : "http://ec2-50-112-45-96.us-west-2.compute.amazonaws.com:9200",
  "type.name" : "_doc",
  "key.ignore" : "true",
  "schema.ignore" : "true",
  "transforms": "ExtractTimestamp",
  "transforms.ExtractTimestamp.type": "org.apache.kafka.connect.transforms.InsertField$Value",
  "transforms.ExtractTimestamp.timestamp.field": "time"
 }
}'