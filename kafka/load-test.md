### Consumer Test
```
root@ip-10-0-0-6:~/confluent-5.2.1# bin/kafka-consumer-perf-test \
> --topic perf-test-07-16-19 \
> --broker-list ec2-35-166-62-149.us-west-2.compute.amazonaws.com:9092,ec2-35-160-33-182.us-west-2.compute.amazonaws.com:9092,ec2-52-38-100-156.us-west-2.compute.amazonaws.com:9092 \
> --messages 500000 --print-metrics
```

### Consumer Results
```
start.time, end.time, data.consumed.in.MB, MB.sec, data.consumed.in.nMsg, nMsg.sec, rebalance.time.ms, fetch.time.ms, fetch.MB.sec, fetch.nMsg.sec
2019-07-16 19:10:18:751, 2019-07-16 19:10:39:480, 2384.5482, 115.0344, 500076, 24124.4633, 34, 20695, 115.2234, 24164.0976

Metric Name                                                                                                      Value
consumer-coordinator-metrics:assigned-partitions:{client-id=consumer-1}                                        : 30.000
consumer-coordinator-metrics:commit-latency-avg:{client-id=consumer-1}                                         : 5.200
consumer-coordinator-metrics:commit-latency-max:{client-id=consumer-1}                                         : 6.000
consumer-coordinator-metrics:commit-rate:{client-id=consumer-1}                                                : 0.110
consumer-coordinator-metrics:commit-total:{client-id=consumer-1}                                               : 5.000
consumer-coordinator-metrics:heartbeat-rate:{client-id=consumer-1}                                             : 0.126
consumer-coordinator-metrics:heartbeat-response-time-max:{client-id=consumer-1}                                : 5.000
consumer-coordinator-metrics:heartbeat-total:{client-id=consumer-1}                                            : 6.000
consumer-coordinator-metrics:join-rate:{client-id=consumer-1}                                                  : 0.020
consumer-coordinator-metrics:join-time-avg:{client-id=consumer-1}                                              : 2.000
consumer-coordinator-metrics:join-time-max:{client-id=consumer-1}                                              : 2.000
consumer-coordinator-metrics:join-total:{client-id=consumer-1}                                                 : 1.000
consumer-coordinator-metrics:last-heartbeat-seconds-ago:{client-id=consumer-1}                                 : 2.000
consumer-coordinator-metrics:sync-rate:{client-id=consumer-1}                                                  : 0.020
consumer-coordinator-metrics:sync-time-avg:{client-id=consumer-1}                                              : 13.000
consumer-coordinator-metrics:sync-time-max:{client-id=consumer-1}                                              : 13.000
consumer-coordinator-metrics:sync-total:{client-id=consumer-1}                                                 : 1.000
consumer-fetch-manager-metrics:bytes-consumed-rate:{client-id=consumer-1, topic=perf-test-07-16-19}            : 49721480.799
consumer-fetch-manager-metrics:bytes-consumed-rate:{client-id=consumer-1}                                      : 49721480.799
consumer-fetch-manager-metrics:bytes-consumed-total:{client-id=consumer-1, topic=perf-test-07-16-19}           : 2500244662.000
consumer-fetch-manager-metrics:bytes-consumed-total:{client-id=consumer-1}                                     : 2500244662.000
consumer-fetch-manager-metrics:fetch-latency-avg:{client-id=consumer-1}                                        : 149.872
consumer-fetch-manager-metrics:fetch-latency-max:{client-id=consumer-1}                                        : 399.000
consumer-fetch-manager-metrics:fetch-rate:{client-id=consumer-1}                                               : 8.042
consumer-fetch-manager-metrics:fetch-size-avg:{client-id=consumer-1, topic=perf-test-07-16-19}                 : 6188724.411
consumer-fetch-manager-metrics:fetch-size-avg:{client-id=consumer-1}                                           : 6188724.411
consumer-fetch-manager-metrics:fetch-size-max:{client-id=consumer-1, topic=perf-test-07-16-19}                 : 10403693.000
consumer-fetch-manager-metrics:fetch-size-max:{client-id=consumer-1}                                           : 10403693.000
consumer-fetch-manager-metrics:fetch-throttle-time-avg:{client-id=consumer-1}                                  : 0.000
consumer-fetch-manager-metrics:fetch-throttle-time-max:{client-id=consumer-1}                                  : 0.000
consumer-fetch-manager-metrics:fetch-total:{client-id=consumer-1}                                              : 405.000
consumer-fetch-manager-metrics:records-consumed-rate:{client-id=consumer-1, topic=perf-test-07-16-19}          : 9926.557
consumer-fetch-manager-metrics:records-consumed-rate:{client-id=consumer-1}                                    : 9926.360
consumer-fetch-manager-metrics:records-consumed-total:{client-id=consumer-1, topic=perf-test-07-16-19}         : 499147.000
consumer-fetch-manager-metrics:records-consumed-total:{client-id=consumer-1}                                   : 499147.000
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}   : 59508.131
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10}  : 52732.541
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11}  : 59516.914
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12}  : 56950.026
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13}  : 59372.000
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14}  : 58674.735
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15}  : 60282.412
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16}  : 56263.581
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17}  : 56141.881
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18}  : 58931.105
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19}  : 58842.588
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}   : 58195.465
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20}  : 60107.000
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21}  : 59262.987
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22}  : 57671.202
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23}  : 59465.892
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24}  : 56666.010
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25}  : 58114.981
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26}  : 59869.174
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27}  : 60601.078
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28}  : 57848.257
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29}  : 60890.042
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}   : 59708.491
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}   : 57356.269
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}   : 53112.232
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}   : 56107.573
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}   : 59582.938
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}   : 57295.706
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}   : 59229.167
consumer-fetch-manager-metrics:records-lag-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}   : 58693.984
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}   : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10}  : 66457.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11}  : 66462.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12}  : 66649.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13}  : 66621.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14}  : 66459.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15}  : 66481.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16}  : 66578.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17}  : 66462.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18}  : 66458.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19}  : 66537.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}   : 66497.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20}  : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21}  : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22}  : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23}  : 66617.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24}  : 66459.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25}  : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26}  : 66580.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27}  : 66598.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28}  : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29}  : 66528.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}   : 66459.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}   : 66461.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}   : 66457.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}   : 66496.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}   : 66457.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}   : 66460.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}   : 66457.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}   : 66566.000
consumer-fetch-manager-metrics:records-lag-max:{client-id=consumer-1}                                          : 66649.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}       : 53212.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10}      : 39363.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11}      : 51144.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12}      : 47827.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13}      : 50528.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14}      : 52384.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15}      : 52591.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16}      : 45369.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17}      : 45978.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18}      : 52588.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19}      : 50528.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}       : 48462.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20}      : 53627.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21}      : 53212.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22}      : 48048.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23}      : 51144.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24}      : 48449.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25}      : 50528.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26}      : 53522.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27}      : 53624.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28}      : 48459.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29}      : 53832.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}       : 53833.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}       : 49278.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}       : 42057.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}       : 45975.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}       : 52381.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}       : 50528.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}       : 52382.000
consumer-fetch-manager-metrics:records-lag:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}       : 49071.000
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}  : 7158.869
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10} : 13931.459
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11} : 7152.086
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12} : 9714.974
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13} : 7296.000
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14} : 7991.265
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15} : 6386.588
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16} : 10400.419
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17} : 10527.119
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18} : 7733.895
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19} : 7825.412
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}  : 8472.535
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20} : 6560.000
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21} : 7404.013
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22} : 8996.798
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23} : 7202.108
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24} : 9999.990
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25} : 8553.019
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26} : 6796.826
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27} : 6063.922
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28} : 8819.743
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29} : 5774.958
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}  : 6957.509
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}  : 9311.731
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}  : 13551.768
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}  : 10560.427
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}  : 7081.062
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}  : 9372.294
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}  : 7434.833
consumer-fetch-manager-metrics:records-lead-avg:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}  : 7974.016
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12} : 16.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13} : 47.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15} : 188.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16} : 86.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19} : 131.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}  : 171.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22} : 208.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23} : 51.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24} : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25} : 208.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26} : 86.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27} : 67.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28} : 208.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29} : 137.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}  : 172.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}  : 208.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}  : 207.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}  : 102.000
consumer-fetch-manager-metrics:records-lead-min:{client-id=consumer-1}                                         : 16.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=0}      : 13455.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=10}     : 27301.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=11}     : 15525.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=12}     : 18838.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=13}     : 16140.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=14}     : 14282.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=15}     : 14078.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=16}     : 21295.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=17}     : 20691.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=18}     : 14077.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=19}     : 16140.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=1}      : 18206.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=20}     : 13040.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=21}     : 13455.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=22}     : 18620.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=23}     : 15524.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=24}     : 18217.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=25}     : 16140.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=26}     : 13144.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=27}     : 13041.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=28}     : 18209.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=29}     : 12833.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=2}      : 12833.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=3}      : 17390.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=4}      : 24607.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=5}      : 20693.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=6}      : 14283.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=7}      : 16140.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=8}      : 14282.000
consumer-fetch-manager-metrics:records-lead:{client-id=consumer-1, topic=perf-test-07-16-19, partition=9}      : 17597.000
consumer-fetch-manager-metrics:records-per-request-avg:{client-id=consumer-1, topic=perf-test-07-16-19}        : 1235.512
consumer-fetch-manager-metrics:records-per-request-avg:{client-id=consumer-1}                                  : 1235.512
kafka-metrics-count:count:{client-id=consumer-1}                                                               : 220.000
```

### Producer Test
```
root@ip-10-0-0-6:~/confluent-5.2.1# bin/kafka-producer-perf-test --topic perf-test-07-16-19 --producer-props bootstrap.servers=ec2-35-166-62-149.us-west-2.compute.amazonaws.com:9092,ec2-35-160-33-182.us-west-2.compute.amazonaws.com:9092,ec2-52-38-100-156.us-west-2.compute.amazonaws.com:9092 --num-records 500000 --throughput 25000 --record-size 5000 --print-metrics
```

### Producer Results
```
111439 records sent, 22287.8 records/sec (106.28 MB/sec), 244.5 ms avg latency, 492.0 ms max latency.
121497 records sent, 24299.4 records/sec (115.87 MB/sec), 251.0 ms avg latency, 598.0 ms max latency.
123149 records sent, 24629.8 records/sec (117.44 MB/sec), 247.8 ms avg latency, 543.0 ms max latency.
112225 records sent, 22445.0 records/sec (107.03 MB/sec), 269.3 ms avg latency, 1119.0 ms max latency.
500000 records sent, 23423.592242 records/sec (111.69 MB/sec), 254.19 ms avg latency, 1119.00 ms max latency, 236 ms 50th, 574 ms 95th, 1065 ms 99th, 1112 ms 99.9th.

Metric Name                                                                                  Value
app-info:commit-id:{client-id=producer-1}                                                  : 325e9879cbc6d612
app-info:version:{client-id=producer-1}                                                    : 2.2.0-cp2
kafka-metrics-count:count:{client-id=producer-1}                                           : 149.000
producer-metrics:batch-size-avg:{client-id=producer-1}                                     : 12450.438
producer-metrics:batch-size-max:{client-id=producer-1}                                     : 15090.000
producer-metrics:batch-split-rate:{client-id=producer-1}                                   : 0.000
producer-metrics:batch-split-total:{client-id=producer-1}                                  : 0.000
producer-metrics:buffer-available-bytes:{client-id=producer-1}                             : 33554432.000
producer-metrics:buffer-exhausted-rate:{client-id=producer-1}                              : 0.000
producer-metrics:buffer-exhausted-total:{client-id=producer-1}                             : 0.000
producer-metrics:buffer-total-bytes:{client-id=producer-1}                                 : 33554432.000
producer-metrics:bufferpool-wait-ratio:{client-id=producer-1}                              : 0.365
producer-metrics:bufferpool-wait-time-total:{client-id=producer-1}                         : 18592767948.000
producer-metrics:compression-rate-avg:{client-id=producer-1}                               : 1.000
producer-metrics:connection-close-rate:{client-id=producer-1}                              : 0.000
producer-metrics:connection-close-total:{client-id=producer-1}                             : 0.000
producer-metrics:connection-count:{client-id=producer-1}                                   : 6.000
producer-metrics:connection-creation-rate:{client-id=producer-1}                           : 0.117
producer-metrics:connection-creation-total:{client-id=producer-1}                          : 6.000
producer-metrics:failed-authentication-rate:{client-id=producer-1}                         : 0.000
producer-metrics:failed-authentication-total:{client-id=producer-1}                        : 0.000
producer-metrics:failed-reauthentication-rate:{client-id=producer-1}                       : 0.000
producer-metrics:failed-reauthentication-total:{client-id=producer-1}                      : 0.000
producer-metrics:incoming-byte-rate:{client-id=producer-1}                                 : 140491.483
producer-metrics:incoming-byte-total:{client-id=producer-1}                                : 7200610.000
producer-metrics:io-ratio:{client-id=producer-1}                                           : 0.034
producer-metrics:io-time-ns-avg:{client-id=producer-1}                                     : 13513.165
producer-metrics:io-wait-ratio:{client-id=producer-1}                                      : 0.233
producer-metrics:io-wait-time-ns-avg:{client-id=producer-1}                                : 93443.735
producer-metrics:io-waittime-total:{client-id=producer-1}                                  : 11997801807.000
producer-metrics:iotime-total:{client-id=producer-1}                                       : 1735036323.000
producer-metrics:metadata-age:{client-id=producer-1}                                       : 21.246
producer-metrics:network-io-rate:{client-id=producer-1}                                    : 1105.449
producer-metrics:network-io-total:{client-id=producer-1}                                   : 56662.000
producer-metrics:outgoing-byte-rate:{client-id=producer-1}                                 : 49170738.552
producer-metrics:outgoing-byte-total:{client-id=producer-1}                                : 2520147863.000
producer-metrics:produce-throttle-time-avg:{client-id=producer-1}                          : 0.000
producer-metrics:produce-throttle-time-max:{client-id=producer-1}                          : 0.000
producer-metrics:reauthentication-latency-avg:{client-id=producer-1}                       : NaN
producer-metrics:reauthentication-latency-max:{client-id=producer-1}                       : NaN
producer-metrics:record-error-rate:{client-id=producer-1}                                  : 0.000
producer-metrics:record-error-total:{client-id=producer-1}                                 : 0.000
producer-metrics:record-queue-time-avg:{client-id=producer-1}                              : 203.171
producer-metrics:record-queue-time-max:{client-id=producer-1}                              : 1109.000
producer-metrics:record-retry-rate:{client-id=producer-1}                                  : 0.000
producer-metrics:record-retry-total:{client-id=producer-1}                                 : 0.000
producer-metrics:record-send-rate:{client-id=producer-1}                                   : 9763.909
producer-metrics:record-send-total:{client-id=producer-1}                                  : 500000.000
producer-metrics:record-size-avg:{client-id=producer-1}                                    : 5086.000
producer-metrics:record-size-max:{client-id=producer-1}                                    : 5086.000
producer-metrics:records-per-request-avg:{client-id=producer-1}                            : 17.653
producer-metrics:request-latency-avg:{client-id=producer-1}                                : 6.721
producer-metrics:request-latency-max:{client-id=producer-1}                                : 698.000
producer-metrics:request-rate:{client-id=producer-1}                                       : 552.735
producer-metrics:request-size-avg:{client-id=producer-1}                                   : 88953.721
producer-metrics:request-size-max:{client-id=producer-1}                                   : 151038.000
producer-metrics:request-total:{client-id=producer-1}                                      : 28331.000
producer-metrics:requests-in-flight:{client-id=producer-1}                                 : 0.000
producer-metrics:response-rate:{client-id=producer-1}                                      : 552.768
producer-metrics:response-total:{client-id=producer-1}                                     : 28331.000
producer-metrics:select-rate:{client-id=producer-1}                                        : 2498.657
producer-metrics:select-total:{client-id=producer-1}                                       : 128396.000
producer-metrics:successful-authentication-no-reauth-total:{client-id=producer-1}          : 0.000
producer-metrics:successful-authentication-rate:{client-id=producer-1}                     : 0.000
producer-metrics:successful-authentication-total:{client-id=producer-1}                    : 0.000
producer-metrics:successful-reauthentication-rate:{client-id=producer-1}                   : 0.000
producer-metrics:successful-reauthentication-total:{client-id=producer-1}                  : 0.000
producer-metrics:waiting-threads:{client-id=producer-1}                                    : 0.000
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node--1}           : 5.506
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node--2}           : 5.502
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node--3}           : 35.119
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node-1001}         : 64850.062
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node-1002}         : 36891.965
producer-node-metrics:incoming-byte-rate:{client-id=producer-1, node-id=node-1003}         : 38821.708
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node--1}          : 282.000
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node--2}          : 282.000
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node--3}          : 1800.000
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node-1001}        : 3320842.000
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node-1002}        : 1889422.000
producer-node-metrics:incoming-byte-total:{client-id=producer-1, node-id=node-1003}        : 1987982.000
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node--1}           : 0.468
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node--2}           : 0.468
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node--3}           : 1.424
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node-1001}         : 16440320.120
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node-1002}         : 16381963.155
producer-node-metrics:outgoing-byte-rate:{client-id=producer-1, node-id=node-1003}         : 16386859.037
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node--1}          : 24.000
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node--2}          : 24.000
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node--3}          : 73.000
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node-1001}        : 841941674.000
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node-1002}        : 839002243.000
producer-node-metrics:outgoing-byte-total:{client-id=producer-1, node-id=node-1003}        : 839203825.000
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node--1}          : NaN
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node--2}          : NaN
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node--3}          : NaN
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node-1001}        : 4.708
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node-1002}        : 10.275
producer-node-metrics:request-latency-avg:{client-id=producer-1, node-id=node-1003}        : 8.819
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node--1}          : NaN
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node--2}          : NaN
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node--3}          : NaN
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node-1001}        : 116.000
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node-1002}        : 698.000
producer-node-metrics:request-latency-max:{client-id=producer-1, node-id=node-1003}        : 57.000
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node--1}                 : 0.020
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node--2}                 : 0.020
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node--3}                 : 0.039
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node-1001}               : 320.765
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node-1002}               : 108.523
producer-node-metrics:request-rate:{client-id=producer-1, node-id=node-1003}               : 123.838
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node--1}             : 24.000
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node--2}             : 24.000
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node--3}             : 36.500
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node-1001}           : 51253.526
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node-1002}           : 150953.984
producer-node-metrics:request-size-avg:{client-id=producer-1, node-id=node-1003}           : 132324.791
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node--1}             : 24.000
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node--2}             : 24.000
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node--3}             : 49.000
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node-1001}           : 151020.000
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node-1002}           : 151038.000
producer-node-metrics:request-size-max:{client-id=producer-1, node-id=node-1003}           : 151020.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node--1}                : 1.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node--2}                : 1.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node--3}                : 2.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node-1001}              : 16427.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node-1002}              : 5558.000
producer-node-metrics:request-total:{client-id=producer-1, node-id=node-1003}              : 6342.000
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node--1}                : 0.020
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node--2}                : 0.020
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node--3}                : 0.039
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node-1001}              : 320.809
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node-1002}              : 108.529
producer-node-metrics:response-rate:{client-id=producer-1, node-id=node-1003}              : 123.855
producer-node-metrics:response-total:{client-id=producer-1, node-id=node--1}               : 1.000
producer-node-metrics:response-total:{client-id=producer-1, node-id=node--2}               : 1.000
producer-node-metrics:response-total:{client-id=producer-1, node-id=node--3}               : 2.000
producer-node-metrics:response-total:{client-id=producer-1, node-id=node-1001}             : 16427.000
producer-node-metrics:response-total:{client-id=producer-1, node-id=node-1002}             : 5558.000
producer-node-metrics:response-total:{client-id=producer-1, node-id=node-1003}             : 6342.000
producer-topic-metrics:byte-rate:{client-id=producer-1, topic=perf-test-07-16-19}          : 49147257.293
producer-topic-metrics:byte-total:{client-id=producer-1, topic=perf-test-07-16-19}         : 2516831046.000
producer-topic-metrics:compression-rate:{client-id=producer-1, topic=perf-test-07-16-19}   : 1.000
producer-topic-metrics:record-error-rate:{client-id=producer-1, topic=perf-test-07-16-19}  : 0.000
producer-topic-metrics:record-error-total:{client-id=producer-1, topic=perf-test-07-16-19} : 0.000
producer-topic-metrics:record-retry-rate:{client-id=producer-1, topic=perf-test-07-16-19}  : 0.000
producer-topic-metrics:record-retry-total:{client-id=producer-1, topic=perf-test-07-16-19} : 0.000
producer-topic-metrics:record-send-rate:{client-id=producer-1, topic=perf-test-07-16-19}   : 9763.718
producer-topic-metrics:record-send-total:{client-id=producer-1, topic=perf-test-07-16-19}  : 500000.000
```