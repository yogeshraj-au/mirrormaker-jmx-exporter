# Use CentOS 7 as the base image
FROM centos:7

# Install Java (required for Kafka)
RUN yum install java-1.8.0-openjdk -y

#Install wget
RUN yum install wget -y

# Set the Kafka version
ENV KAFKA_VERSION=3.1.2
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Download and extract Kafka
RUN wget "https://archive.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz" -O /tmp/kafka.tgz && \
    tar -xzf /tmp/kafka.tgz -C /opt && \
    rm /tmp/kafka.tgz

# Create Directory structure for monitoring
RUN mkdir -p $KAFKA_HOME/monitoring
ADD https://repo.maven.apache.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.15.0/jmx_prometheus_javaagent-0.15.0.jar $KAFKA_HOME/monitoring/
COPY mirrormaker.yml $KAFKA_HOME/monitoring

# Add the jmx config
RUN sed -i '16i export KAFKA_OPTS="-javaagent:$KAFKA_HOME/monitoring/jmx_prometheus_javaagent-0.15.0.jar=5060:$KAFKA_HOME/monitoring/mirrormaker.yml"' $KAFKA_HOME/bin/kafka-mirror-maker.sh

# Expose jmx port
EXPOSE 5060

ENTRYPOINT [ "/opt/kafka_2.13-3.1.2/bin/kafka-mirror-maker.sh" ]

CMD [ "--consumer.config", "/opt/kafka_2.13-3.1.2/config/consumer.properties", "--producer.config", "/opt/kafka_2.13-3.1.2/config/producer.properties", "--whitelist", "test" ]