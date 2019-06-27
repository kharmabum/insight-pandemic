#!/bin/sh

NAME=$1

curl -X POST 'http://ec2-54-214-145-33.us-west-2.compute.amazonaws.com:8083/connectors'    \
-H 'Content-Type: application/json'     \
-d                                      \
'{
 "name" : "s3-sink-$NAME",
 "config" : {
  "connector.class" : "io.confluent.connect.s3.S3SinkConnector",
  "tasks.max" : "1",
  "topics" : "$NAME",
  "s3.region": "us-west-2",
  "s3.bucket.name": "insight-pandemic",
  "s3.part.size": "5242880",
  "flush.size": "3",
  "storage.class": "io.confluent.connect.s3.storage.S3Storage",
  "format.class": "io.confluent.connect.s3.format.json.JsonFormat",
  "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
  "schema.compatibility": "NONE",
  "transforms": "ExtractTimestamp",
  "transforms.ExtractTimestamp.type": "org.apache.kafka.connect.transforms.InsertField$Value",
  "transforms.ExtractTimestamp.timestamp.field": "time"
 }
}'



