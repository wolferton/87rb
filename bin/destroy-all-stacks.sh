#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}

destroy-storage-bucket.sh

ALL_STACKS=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --output text | cut -f4 | grep 87Rb)

for STACK in $ALL_STACKS
do
	aws cloudformation delete-stack --stack-name $STACK
done