#!/bin/bash
aws ec2 describe-instances --output text | grep ^STATE.*running$ | wc -l
