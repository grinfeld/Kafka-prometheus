FROM confluentinc/cp-kafka-connect

ADD first-start.sh /etc/confluent/docker/first-start.sh

VOLUME ["/scripts"]

ADD MirrorSourceConnector.json /scripts/MirrorSourceConnector.json

ADD MirrorCheckpointConnector.json /scripts/MirrorCheckpointConnector.json

ADD MirrorHeartbeatConnector.json /scripts/MirrorHeartbeatConnector.json

RUN ["chmod", "+x", "/etc/confluent/docker/first-start.sh"]