#!/bin/bash
ELB_FULL_LIST=`aws elb describe-load-balancers --output=json | jq '.LoadBalancerDescriptions | map("\(.LoadBalancerName) \(.DNSName) INSTANCIES: \(.Instances) ###")' | sed -e "s/\[//g" -e 's/"//g' -e "s/\]//g"`

for i in $ELB_FULL_LIST
  do
    if [[ $i =~ InstanceId ]]
      then
        for j in $i
          do
            #echo $j | awk -F'InstanceId' '{print $2}'
            echo $j
          done
      else
        echo 
        echo $i
    fi
  done
