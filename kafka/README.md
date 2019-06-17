# Kafka

## Requirements
- 3 zookeeper nodes
- 3 broker nodes

These instances must be open to `ssh` and able to access S3. See associated resources in `insight-pandemic/terraform/main.tf`.

## Configuration
First review [these instructions](https://docs.confluent.io/current/installation/installing_cp/zip-tar.html#prod-kafka-cli-install) for manually installing the Confluent platform on your instances. The Apache Kafka [QuickStart](https://kafka.apache.org/documentation.html#quickstart) documentation is also quite helpful.

1. Download the Confluent platform files

```
curl -O http://packages.confluent.io/archive/5.2/confluent-5.2.1-2.12.tar.gz
```

2. Unzip contents

```
tar -zxvf confluent-5.2.1-2.12.tar.gz
```

3. Edit `./confluent-5.2.1-2.12/etc/kafka/zookeeper.properties` to exclusively include:

```
tickTime=2000
dataDir=/var/lib/zookeeper/
clientPort=2181
initLimit=5
syncLimit=2
server.1=ZOOKEEPER-NODE-1-HOSTNAME:2888:3888
server.2=ZOOKEEPER-NODE-2-HOSTNAME:2888:3888
server.3=ZOOKEEPER-NODE-3-HOSTNAME:2888:3888
autopurge.snapRetainCount=3
autopurge.purgeInterval=24
```

4. Edit `./confluent-5.2.1-2.12/etc/kafka/server.properties` to include, leave the rest as is:

```
...
zookeeper.connect=ZOOKEEPER-NODE-1-HOSTNAME:2181,ZOOKEEPER-NODE-2-HOSTNAME:2181,ZOOKEEPER-NODE-3-HOSTNAME:2181
...
listeners=PLAINTEXT://0.0.0.0:9092
...

#broker.id=0
broker.id.generation.enable=true
...
num.partitions = 30
...
default.replication.factor = 2
auto.create.topics.enable = true
...

```

5. Repackage the Confluent platform files:

```
tar -cvzhf confluent-5.2.1.tar.gz confluent-5.2.1
```


6. Upload `confluent-5.2.1.tar.gz` to the S3 bucket created by [Terraform](../terraform/README.md) either via the `aws` cli or the S3 console.

7. `ssh` into each Zookeeper node:

```
ssh -i ~/.ssh/YOUR-SAVED-KEYPAIR-NAME.pem ubuntu@ZOOKEEPER-HOST
```

8. On each Zookeeper node, run:

```
sudo -i
curl -O https://YOUR-S3-BUCKET-NAME.s3-us-west-2.amazonaws.com/confluent-5.2.1.tar.gz
tar -xvzf confluent-5.2.1.tar.gz
mkdir /var/lib/zookeeper
echo "UNIQUE-ID" > /var/lib/zookeeper/myid # these ids must match those found in `zookeeper.properties`
sudo apt-get update
sudo apt-get install default-jre
~/confluent-5.2.1/bin/zookeeper-server-start ~/confluent-5.2.1/etc/kafka/zookeeper.properties
```

9. `ssh` into each broker node:

```
ssh -i ~/.ssh/YOUR-SAVED-KEYPAIR-NAME.pem ubuntu@BROKER-HOST
```

10. On each broker node, run:

```
sudo -i
curl -O https://YOUR-S3-BUCKET-NAME.s3-us-west-2.amazonaws.com/confluent-5.2.1.tar.gz
tar -xvzf confluent-5.2.1.tar.gz
echo "advertised.listeners=PLAINTEXT://THIS_BROKER_HOST_PUBLIC_DNS:9092" >> ~/confluent-5.2.1/etc/kafka/server.properties
sudo apt-get update
sudo apt-get install default-jre
~/confluent-5.2.1/bin/kafka-server-start ~/confluent-5.2.1/etc/kafka/server.properties
```
