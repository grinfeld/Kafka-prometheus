FROM confluentinc/cp-kafka-connect

RUN apt-get update && apt-get install procps -y && apt-get install curl -y && apt-get install net-tools -y && apt-get install telnet -y

ADD first-start.sh /etc/confluent/docker/first-start.sh

VOLUME ["/scripts"]

ADD MirrorSourceConnector.json /scripts/MirrorSourceConnector.json

ADD MirrorCheckpointConnector.json /scripts/MirrorCheckpointConnector.json

ADD MirrorHeartbeatConnector.json /scripts/MirrorHeartbeatConnector.json

RUN ["chmod", "+x", "/etc/confluent/docker/first-start.sh"]