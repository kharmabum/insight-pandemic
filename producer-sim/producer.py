import random
import sys
import time
import json
from kafka.client import KafkaClient
from kafka.producer import KafkaProducer
from kafka.errors import KafkaError


class Producer(object):

    def __init__(self, hosts):
        print(hosts)
        self.producer = KafkaProducer(
            bootstrap_servers=hosts,
            value_serializer=lambda
            m: json.dumps(m).encode('ascii')
            )


    def produce_msgs(self):
        msg_cnt = 0
        while msg_cnt == 0:# True:

            epoch_timestamp   = int(str(time.time()).split('.')[0])
            price  = random.randint(-10, 10)/10.0
            volume = random.uniform(1, 1000)

            message = {'time': epoch_timestamp, 'price': price, 'volume': volume}
            print(message)
            future = self.producer.send('test-topic', message)
            msg_cnt += 1

            # Block for 'synchronous' sends
            try:
                record_metadata = future.get(timeout=3)
            except KafkaError:
                # Decide what to do if produce request failed...
                print(sys.exc_info()[0])
                return

            # Successful result returns assigned partition and offset
            print(record_metadata.topic)
            print(record_metadata.partition)
            print(record_metadata.offset)

            #time.sleep(5) # wait 5 seconds

            # block until all async messages are sent
            # self.producer.flush()

            # def on_send_success(record_metadata):
            #     print(record_metadata.topic)
            #     print(record_metadata.partition)
            #     print(record_metadata.offset)

            # def on_send_error(excp):
            #     log.error('I am an errback', exc_info=excp)
            #     # handle exception

            # # produce asynchronously with callbacks
            # producer.send('my-topic', b'raw_bytes').add_callback(on_send_success).add_errback(on_send_error)


if __name__ == "__main__":
    args = sys.argv
    hosts = str(args[1])
    prod = Producer(hosts)
    prod.produce_msgs()