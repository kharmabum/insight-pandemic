#!/bin/sh

INDEX_NAME=$1

curl -X PUT "http://ec2-50-112-45-96.us-west-2.compute.amazonaws.com:9200/$INDEX_NAME" \
-H 'Content-Type: application/json; charset=utf-8' \
-d \
'
{
    "mappings": {
        "numeric_detection": true,
        "properties": {
            "time":  {
                "type":   "date",
                "format": "epoch_millis"
            }
        }
    }
}'