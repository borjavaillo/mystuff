#!/usr/bin/env python
import boto
cw = boto.connect_cloudwatch()
metrics = cw.list_metrics()
my_metrics = []
for metric in metrics:
  if 'InstanceId' in metric.dimensions:
    if instance.id in metric.dimensions['InstanceId']:
      my_metrics.append(metric)
print my_metrics
