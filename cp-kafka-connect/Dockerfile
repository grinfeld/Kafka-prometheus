FROM confluentinc/cp-kafka-connect:5.2.1

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-datagen:latest

#ADD ./confluentinc-kafka-connect-jdbc-5.2.1/* /kafka/connect/confluentinc-kafka-connect-jdbc/

ADD ./ojdbc8.jar /usr/share/java/kafka-connect-jdbc/