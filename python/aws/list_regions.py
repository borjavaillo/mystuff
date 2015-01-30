#!/usr/bin/env python
import boto.ec2

regions = boto.ec2.regions()
print "\nAvailable regions:"
for r in regions:
  print r
