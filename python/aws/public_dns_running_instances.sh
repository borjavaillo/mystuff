#!/bin/bash
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[PublicDnsName]' --output text | grep -v ^None
