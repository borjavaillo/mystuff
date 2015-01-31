#!/usr/bin/env python
# Establihing the connection for the EC2 service
import boto.ec2
conn = boto.ec2.connect_to_region("eu-west-1")

# get running instances
reservations = conn.get_all_instance_status()

# reservations is a list that contains instances in the horrible i-xxxxx format
for instance in reservations:
  status=instance.system_status
  print instance, status
