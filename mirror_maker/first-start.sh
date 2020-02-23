#!/usr/bin/env sh

PORT=$1

if [ -z $PORT ]
then
  PORT="8083"
fi

echo "Checking the connect api is up on port $PORT"

while ! nc -z localhost $PORT </dev/null; do sleep 10; done

curl -H "Content-Type: application/json" "http://localhost:$PORT/connectors"

curl -X POST -H "Content-Type: application/json" --data "@/scripts/MirrorSourceConnector.json" "http://localhost:$PORT/connectors"

curl -H "Content-Type: application/json" "http://localhost:$PORT/connectors"

curl -X POST -H "Content-Type: application/json" --data "@/scripts/MirrorCheckpointConnector.json" "http://localhost:$PORT/connectors"

curl -H "Content-Type: application/json" "http://localhost:$PORT/connectors"

curl -X POST -H "Content-Type: application/json" --data "@/scripts/MirrorHeartbeatConnector.json" "http://localhost:$PORT/connectors"