#!/bin/bash 

# We accept any number of positional parameters but we process them on only two groups ( and we require at least existance of $1 and $2 ): $1 emulates the behaviour of the -s switch on ec2ssh
# whereas {$2..$N} becomes the command
# ex: ./ssh_command_by_security_group.sh elastic "date; ls -ld /var/tmp"
# 
if [ "$#" -lt "2" ] 
then 
echo 
echo "usage $0 [SG (sub)token ] [CONCURRENT] [bash command]"
echo "the (sub)tokens work emulating the behaviour of the -s switch on ec2ssh"
echo "if you want your command to be executed in parallel on all remote hosts use the CONCURRENT flag"
echo "default execution is sequential"
echo "ex: ./ssh_command_by_security_group.sh elastic \"date; ls -ld /var/tmp\"" 
exit 32
fi

# COMMAND is $* except for $1...
COMMAND=`echo $*|sed -e "s/$1//"`
# Because S1 ( $TOKEN ) is what emulates the -s switch on ec2ssh
TOKEN=$1
HOSTS=`aws ec2 describe-instances --filters "Name=group-name,Values=*$TOKEN*" --query 'Reservations[*].Instances[*].PublicDnsName' --output=json | grep ec2 | sed -e "s/.*\"ec2/ec2/g" -e "s/\".*$/,/g" -e "s/ec2/root@ec2/g" | sed -e "s/ //g"`
# Here we decide if the execution is concurrent or sequential ( default )
if echo $COMMAND | grep -q CONCURRENT 
then
COMMAND=`echo $COMMAND|sed -e "s/CONCURRENT//g"`
dsh -c -M -m `echo $HOSTS|sed -e "s/ //g"|sed -e "s/,$//g"` $COMMAND
else 
dsh -M -m `echo $HOSTS|sed -e "s/ //g"|sed -e "s/,$//g"` $COMMAND
fi
