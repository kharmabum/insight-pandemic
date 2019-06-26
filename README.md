insight-pandemic
=================

<img alt="Pandemic" src="https://i.imgur.com/76vAcwr.png" width="500px">

Pandemic represents proof-of-engineering for a generic and extensible [public health surveillance system](https://www.ncbi.nlm.nih.gov/books/NBK11770/). The project was initiated as part of [Insight's Data Engineering Fellowship](https://www.insightdataengineering.com/).

## Goals

Pandemic demonstrates a standards-based platform for monitoring distributed resources and events in real-time. It's primary goals are:

- Support ingestion, real-time analysis, and long-term storage of heterogenous data streams
- Support non-technical users in adding new data sources and running ad-hoc queries
- Provide real-time monitoring via a web interface


For additional background refer to the [initial project proposal](https://github.com/kharmabum/insight-pandemic/blob/master/PROPOSAL.md) and [latest presentation slides](https://docs.google.com/presentation/d/1d2T31dwfiBEJT7Y83PhtmF1qy--aFn-EWGzb_LeerBU/edit#slide=id.g5b106e8208_0_76).

For details on planned and tagged releases, see [Milestones](https://github.com/kharmabum/insight-pandemic/milestones) and [Releases](https://github.com/kharmabum/insight-pandemic/releases) respectively.


## Overview

Pandemic includes several interacting components.

1. [Data and Simulated Sources](#data)
1. [Provisioning – Terraform](#provisioning)
1. [Ingestion – Kafka](#kafka)
1. [Querying – KSQL](#ksql)
1. [Connectors/Sinks – S3 and Elasticsearch](#kafka-connectors)
1. [Dashboard - Kibana](#elasticsearch-and-kibana)

Data in Pandemic moves from simulated data producers (e.g. hospitals and pharmacies) into a stream ingestion system from which it it is available to any number of consumers. At present, interactive querying and persistant stream transformations are supported via KSQL; long term storage and historical analysis are available via a consumer which pulls data into S3; and real-time monitoring and data-exploration is available via a consumer which pulls data into Elasticsearch indicies which are exposed via a [Kibana interface](http://ec2-50-112-45-96.us-west-2.compute.amazonaws.com:5601).


### Architecture
<img alt="architecture" src="https://i.imgur.com/SSX4Hf2.png" width="1000px">


## Data

Pandemic leverages the California OSHPD Public Patient Discharge and Emergency Department [data sets](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UBDMR6&version=1.0). These data sets include discharge records for emergency and non-emergency healthcare facilities in several CA regions over the span of nearly 10 years. Each record includes at least the facility id and name, associated diagnoses, and performed procedures related to the discharge event.

The included [`producer.py`](https://github.com/kharmabum/insight-pandemic/blob/master/producer-sim/producer.py) script simulates the activity of a data producer (e.g. hospital, pharmacy, emergency room, etc) by sampling from one of the OSHPD data sets and enriching with additional "virtual" features (e.g. timestamps, patient age, etc)


### Requirements
- OSHPD Patient Discharge data, available [here](https://oshpd.ca.gov/data-and-reports/request-data/public-data/#top)
- Ensure`Python 3.7.x` and `tmux` are installed on your machine
- Create a virtual python environment, activate it, and install dependencies:

```
python3 -m venv env
source env/bin/activate
pip3 install -r requirements.txt
```

### Running `producer.py`

To execute the producer script in synchronous mode (waiting for responses) with verbose output, run:
```
python3 producer.py -sv -t $KAKFA_TOPIC -b $KAFKA_BROKERS -f $DATA_FILE_LOCATION
# e.g. python3 producer.py -sv -t "ed-raw" -b "ec2-35-166-62-149.us-west-2.compute.amazonaws.com" -f data/2014\ ED_Comma_Labels/DATA\ FOLDER/Public14/ED_Public_2014_LA_LBL.txt
```

The script can also be run for several data sources concurrently on the same machine using the shell and window multiplexer, `tmux`. See [`producer-sim/spawn-producers.sh`](https://github.com/kharmabum/insight-pandemic/blob/master/producer-sim/spawn-producers.sh) for an example.

## Provisioning

Pandemic uses Terraform to specify and provision all required infrastructure (VPC, security groups, instances, etc). See [`terraform/main.tf`](https://github.com/kharmabum/insight-pandemic/blob/master/terraform/main.tf) for a full description of all resources.

### Requirements

- Terraform `0.12.x`
- A premade AWS keypair, see `keypair_name` in `terraform/terraform.tfvars`
- AWS Account and IAM user with associated key and secret stored in `secrets.auto.tfvars`. This user should have, at a minimum, a policy with
full EC2 and IAM pass role access, for example:
```
{
      "Version": "2012-10-17",
      "Statement": [{
        "Effect": "Allow",
        "Action": [
          "iam:PassRole",
          "ec2:*"
        ],
        "Resource": "*"
      }]
    }
```

### Deploy Instructions

- **WARNING**: Provisioning these resources is beyond the scope of AWS Free Tier.
- Run `terraform init && terraform apply` and approve changes.
- To destroy all created resources, run `terraform destroy`

## Kafka

Pandemic leverages Kafka as a distributed stream processing platform and analytics engine (see [section](#ksql) on KSQL). For each declared Avro schema, Pandemic creates a new topic in Kafka which is partitioned, by default, on the generating source (e.g. facility identifier, `fac_id`).

### Requirements
- 3 zookeeper nodes
- 3 broker nodes

These instances, at a minimum, must be open to `ssh`, each other, and able to access S3. See associated resources in [`terraform/main.tf`](https://github.com/kharmabum/insight-pandemic/blob/master/terraform/main.tf).

### Installing and Configuring Kafka

First, review Confluent's [instructions](https://docs.confluent.io/current/installation/installing_cp/zip-tar.html#prod-kafka-cli-install) for manually installing the Confluent platform on your instances. The Apache Kafka QuickStart [documentation](https://kafka.apache.org/documentation.html#quickstart) is also quite helpful for validating that your servers are set up correctly.

At a minimum, you must perform the following steps to deploy your own Kafka cluster. These steps assume instances for the cluster have already been provisioned and made available (see [Provisioning](#provisioning)).

At the completion of these steps, you can optionally install the [Confluent Control Center](https://www.confluent.io/confluent-control-center/) (30 day trial period) to monitor your cluster on one of your instances. Refer to these [instructions](https://docs.confluent.io/current/control-center/installation/index.html) to install. Note this project includes its configuration `.properties` files (referenced below) in [`kafka/config`](https://github.com/kharmabum/insight-pandemic/tree/master/kafka/config).

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
server.1=<ZOOKEEPER-NODE-1-HOSTNAME>:2888:3888
server.2=<ZOOKEEPER-NODE-2-HOSTNAME>:2888:3888
server.3=<ZOOKEEPER-NODE-3-HOSTNAME>:2888:3888
autopurge.snapRetainCount=3
autopurge.purgeInterval=24
```

4. Edit `./confluent-5.2.1-2.12/etc/kafka/server.properties` to include, leave the rest as is:

```
...
zookeeper.connect=<ZOOKEEPER-NODE-1-HOSTNAME>:2181,<ZOOKEEPER-NODE-2-HOSTNAME>:2181,<ZOOKEEPER-NODE-3-HOSTNAME>:2181
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


6. Upload `confluent-5.2.1.tar.gz` to your S3 bucket either via the `aws` cli or the S3 console.

7. `ssh` into each Zookeeper node:

```
ssh -i ~/.ssh/<YOUR-KEYPAIR-NAME>.pem ubuntu@<THIS-ZOOKEEPER-HOST>
```

8. On each Zookeeper node, run:

```
sudo -i
curl -O https://<YOUR-S3-BUCKET-NAME>.s3-<YOUR-VPC-REGION>.amazonaws.com/confluent-5.2.1.tar.gz
tar -xvzf confluent-5.2.1.tar.gz
mkdir /var/lib/zookeeper
echo "<ID>" > /var/lib/zookeeper/myid # these ids must match those found in `zookeeper.properties`
sudo apt-get update
sudo apt-get install default-jre
~/confluent-5.2.1/bin/zookeeper-server-start ~/confluent-5.2.1/etc/kafka/zookeeper.properties
```

9. `ssh` into each broker node:

```
ssh -i ~/.ssh/<YOUR-KEYPAIR-NAME>.pem ubuntu@<THIS-BROKER-HOST>
```

10. On each broker node, run:

```
sudo -i
curl -O https://<YOUR-S3-BUCKET-NAME>.s3-<YOUR-VPC-REGION>.amazonaws.com/confluent-5.2.1.tar.gz
tar -xvzf confluent-5.2.1.tar.gz
echo "advertised.listeners=PLAINTEXT://<THIS-BROKER-HOST>:9092" >> ~/confluent-5.2.1/etc/kafka/server.properties
sudo apt-get update
sudo apt-get install default-jre
~/confluent-5.2.1/bin/kafka-server-start ~/confluent-5.2.1/etc/kafka/server.properties
```

## KSQL

KSQL is a querying engine built on top of Kafka Streams (see [here](https://docs.confluent.io/current/ksql/docs/concepts/ksql-and-kafka-streams.html#ksql-and-kafka-streams) for comparison). KSQL adds windowing semantics to a SQL-like query language, enabling real-time streaming business logic (e.g. alerts, anomaly-detection, ETL) with only a few lines of SQL code.

### Requirements

- A running KSQL server.
- The KSQL CLI (a component of the Confluent platform)

See associated resources in `terraform/main.tf` and `kafka/config/ksql-server.properties`. Instructions for deploying a KSQL server to an individual instance or cluster are available on Confluent's [website](https://docs.confluent.io/current/ksql/docs/installation/installing.html).

### Running KSQL queries

Until v0.2, specifically [#2](https://github.com/kharmabum/insight-pandemic/issues/9), KSQL queries are support via the Control Center (if installed) and the KSQL CLI. From either interface, a KSQL server is connected to, and queries may be added and persisted to the running server, e.g. the following results in a new table being persisted to the KSQL server which includes the number of events from each facility within the past minute (by default since the issuance of the query, use `SET 'auto.offset.reset'='earliest';` in the CLI to process all data):

```
CREATE TABLE ED_RAW_PER_FACILITY_PER_MINUTE AS
  SELECT fac_id,
         count(*)
  FROM ED_RAW
  WINDOW TUMBLING (SIZE 1 MINUTE)
  GROUP BY fac_id;
```

To start the KSQL CLI, run:

```
> confluent-5.2.1/bin/ksql http://<KSQL-SERVER-HOST>:8088
ksql> SHOW TOPICS;
```

## Kafka Connectors

### Requirements

- At least one EC2 instance, see `connector_server` in `terraform/main.tf`
- IAM policy permitting, at a minimum, PUTs to S3, e.g:

```
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "s3:*",
                "Resource": [
                    "arn:aws:s3:::<YOUR-BUCKET-NAME>/*"
                ]
            }
        ]
    }
```
- IAM role ("instance profile") with above policy, see usage of `"S3-Sink-EC2-Instance-Profile"` in `terraform/main.tf`

### Running Kafka Connectors (Standalone)

On your EC2 instance, install the Confluent Platform (see Kafka instructions), then run:
```
confluent-5.2.1/bin/confluent-hub install confluentinc/kafka-connect-s3:latest
confluent-5.2.1/bin/confluent-hub install confluentinc/kafka-connect-elasticsearch:latest
confluent-5.2.1/bin/connect-standalone worker.properties connector1.properties [connector2.properties connector3.properties ...]
# example: confluent-5.2.1/bin/connect-standalone confluent-5.2.1/etc/kafka/connect-standalone.properties confluent-5.2.1/etc/kafka-connect-s3/quickstart-s3.properties
```

## Elasticsearch and Kibana

### Requirements

- At least one EC2 instance with ports open to ingress on `5601` and `9200`, see `es_kibana_server` and `elasticsearch_sg` in `terraform/main.tf`
- Access to a Kafka Connect instance or cluster than can run a `kafka-connect-elasticsearch` worker.

### Installation

- Install Elasticsearch and Kibana on the instance:

```
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install elasticsearch
sudo apt-get install kibana

```
- Configure Elasticsearch, see [documentation](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/important-settings.html), and `elasticsearch/jvm.options`, `elasticsearch/elasticsearch.yml`, `elasticsearch/elasticsearch.service`
- Configure your instance, see [docs](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/system-config.html), but in particular, disable swapping:
```
sudo swapoff -a
```

- See the [documentation](https://www.elastic.co/guide/en/elasticsearch/reference/7.1/deb.html#deb-layout) for the directory layout and location of configuration files.
- To enable Elasticsearch logging, the `--quiet` option must be removed from the `ExecStart` command line in the `/usr/lib/systemd/system/elasticsearch.service` file


- To start Elasticsearch, run:
```

sudo systemctl start elasticsearch.service
```

- To tail journal entries for the elasticsearch service:

```
sudo journalctl -f --unit elasticsearch
```

- Configure Kibana, see [documentation](https://www.elastic.co/guide/en/kibana/7.1/settings.html) but, in particular, ensure the following are set in `/etc/kibana/kibana.yml` (see `/elasticsearch/kibana.yml`):

```
server.host: 0.0.0.0 # bind to all interfaces
```
- To start Kibana, run:
```
sudo systemctl start kibana.service
```

- View Kibana UI in your default browser at `<ES-KIBANA-HOST>:5601`

