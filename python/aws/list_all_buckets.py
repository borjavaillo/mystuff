#!/usr/bin/env python
import time
import boto
import os

s3  = boto.connect_s3()

buckets = s3.get_all_buckets()
print "\nCurrently used S3 Buckets:"
for b in buckets:
  print "\t%s" % (b.name)
