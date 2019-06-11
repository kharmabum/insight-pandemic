# Kafka

## Configuration

See [these instructions](https://docs.confluent.io/current/installation/installing_cp/zip-tar.html#prod-kafka-cli-install) for manually installing Zookeeper and broker nodes in a Kafka cluster. The configuration used for this project is stored at `insight-pandemic/kafka/config/confluent-5.2.1` and on S3. See the script in `kafka/config`. Steps were:

1. Push zipped configuration to s3
2. Pull down and unzip on nodes
3. Run `echo '[1, 2, 3]' > /var/lib/zookeeper/myid` on Zookeeper nodes
4. Start services (zookeeper nodes first)
    - `./bin/zookeeper-server-start ./etc/kafka/zookeeper.properties`
    - `./bin/schema-registry-start ./etc/schema-registry/schema-registry.properties`
    - `./bin/kafka-server-start ./etc/kafka/server.properties`
