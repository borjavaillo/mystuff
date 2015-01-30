#!/bin/bash

if [ -n "$1" ]
  then
    aws ec2 describe-security-groups --output=json --filters "Name=group-name,Values=${1}" | jq '.SecurityGroups[].IpPermissions[].UserIdGroupPairs[].GroupName' | sort -u
    exit 
fi

# This script lists all running instances SG and, for each one of them, outputs the list of SG that contain it ( dependency relationship )

RUNNING_EC2_SG_LIST=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --output=json | jq '.Reservations[].Instances[].SecurityGroups[].GroupName' | sed -e 's/"//g'` 

for i in $RUNNING_EC2_SG_LIST
  do
    echo 
    echo "SECURITY GROUP ${i} is contained by:"
    aws ec2 describe-security-groups --output=json --filters "Name=group-name,Values=${i}" | jq '.SecurityGroups[].IpPermissions[].UserIdGroupPairs[].GroupName' | sort -u
done
