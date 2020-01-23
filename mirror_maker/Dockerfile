FROM confluentinc/cp-kafka

ARG CONSUMER_CONFIG
ENV CONSUMER_CONFIG=${CONSUMER_CONFIG}

ARG PRODUCER_CONFIG
ENV PRODUCER_CONFIG=${PRODUCER_CONFIG}

ARG NUM_THREADS
ENV NUM_THREADS=${NUM_THREADS}

# mirror-maker 1.x
CMD ["bash", "-c", "kafka-mirror-maker --consumer.config ${CONSUMER_CONFIG} --producer.config ${PRODUCER_CONFIG} --num.streams ${NUM_THREADS} --whitelist='.*'"]