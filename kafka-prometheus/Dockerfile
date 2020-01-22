FROM confluentinc/cp-kafka:latest

RUN apt-get update && apt-get install -y apt-utils

RUN apt-get install -y bash

RUN apt-get install -y net-tools

RUN apt-get install -y vim

RUN apt-get install -y locate

ADD ./libs/* /usr/local/share/jars/

