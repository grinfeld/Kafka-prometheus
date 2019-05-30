#!/usr/bin/env bash

curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @jdbc-oracle-sink.json


# curl -X DELETE http://localhost:8083/connectors/jdbc-oracle-sink

# sh kafka-console-producer.sh --broker-list kafka-1:9092 --topic MAIL_RELAY_STATUS --property parse.key=true --property key.separator=,

# "12345679",{"mimeMessageId": "12345679","state": "bounce","errorMessage": "error","recipients": "972544403945"}