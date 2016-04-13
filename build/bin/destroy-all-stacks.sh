#!/bin/bash
source set-87rb-env.sh

destroy-storage-bucket.sh

ALL_STACKS=$(aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --output text | cut -f4 | grep 87Rb)

for STACK in $ALL_STACKS
do
	aws cloudformation delete-stack --stack-name $STACK
done