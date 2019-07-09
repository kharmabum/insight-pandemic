#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import csv
import random
import sys
import time
import json
from typing import Dict, Callable, Optional, List, Text
from kafka.client import KafkaClient
from kafka.producer import KafkaProducer
from kafka.errors import KafkaError

class Config(object):
    def __init__(self):
        super(Config, self).__init__()

config = Config()

class Reader(object):
    """Reads and processes from data files"""
    def __init__(self, file_paths: List[str]):
        super(Reader, self).__init__()
        self.file_paths = file_paths

    def process_data(self, process: Callable, validate: Optional[Callable]=None, stop_signal: Optional[Callable]=None):
        """Read csv data row by row, processing and validating each row with handlers (if provided)
           Note that csv.reader provides no type coercion facilities, all returned values are strings.
        """
        for path in self.file_paths:
            with open(path, 'r', newline='') as f:
                print(f'Reading data from {path}')

                reader = csv.DictReader(f)
                for row in reader:
                    try:
                        if callable(validate):
                            validate(row)

                        process(row)

                        if callable(stop_signal) & stop_signal(row):
                            return

                    except Exception as e:
                        print(e)

class Producer(object):
    """Delivers messages to a specified Kafka topic"""
    def __init__(self, topic: str, hosts: str, frequency: int):
        self.topic = topic
        self.frequency = frequency if frequency > 0 else float('inf')
        self.producer = KafkaProducer(
            bootstrap_servers=hosts,
            value_serializer=lambda m: json.dumps(m).encode('ascii'))


    def send_message(self, message: str):
        while True:

            def on_send_success(record_metadata):
                if config.is_verbose:
                    print("topic: " + str(record_metadata.topic))
                    print("partition: " + str(record_metadata.partition))
                    print("offset: " + str(record_metadata.offset))

            def on_send_error(excp):
                if config.is_verbose:
                    print(str(excp))

            # Post message
            future = self.producer.send(self.topic, message)

            # Block for 'synchronous' sends
            if config.wait_for_response:
                try:
                    record_metadata = future.get(timeout=5)
                    on_send_success(record_metadata)
                except KafkaError:
                    on_send_error(sys.exc_info()[0])

            # produce asynchronously with callbacks
            else:
                future.add_callback(on_send_success).add_errback(on_send_error)

            time.sleep(1/self.frequency) # ensure frequency cap


# Example usage: python3 producer.py -sv -t $KAKFA_TOPIC -b $KAFKA_BROKERS -f $DATA_FILE_LOCATION
if __name__ == "__main__":

    # Configure argument parser
    parser = argparse.ArgumentParser(description='Simulates data producers from csv formatted files.')
    parser.add_argument('-m','--max',
                        dest='frequency',
                        type=float,
                        default=0.5,
                        help='Maximum requests per second. Defaults to 0.5.')
    parser.add_argument('-s','--synchronous-mode',
                        dest='wait_for_response',
                        action='store_true',
                        help='Wait for responses')
    parser.add_argument('-v',
                        dest='is_verbose',
                        action='store_true',
                        help=('Enables verbose logging.'))
    parser.add_argument('-t','--topic',
                        dest='topic',
                        type=str,
                        help='Kafka topic to publish to',
                        required=True)
    parser.add_argument('-b','--bootstrap-servers',
                        dest='brokers',
                        type=str,
                        help='List of Kafka brokers, e.g. "host1:9092,host2:9092,host3:9092..."',
                        required=True)
    parser.add_argument('-f','--files',
                        dest='files',
                        nargs='+',
                        help='Data files in csv format',
                        required=True)

    # Collect arguments
    args = parser.parse_args()
    frequency = args.frequency
    files = args.files
    brokers = args.brokers
    topic = args.topic
    config.wait_for_response = args.wait_for_response
    config.is_verbose = args.is_verbose

    reader = Reader(files)
    producer = Producer(topic, brokers, frequency)

    reader.process_data(process=lambda row: producer.send_message(row))
