#!/bin/bash
#Destroys the AWS CloudFormation stack containing a single deployment of 87Rb
USAGE="Usage: $( basename $0 ) deployment-id"
[ -z "$1" ] && echo $USAGE && exit 1

source set-87rb-env.sh

DEPLOYMENT_ID=$1
STACK_NAME=$( 87rbStackName $DEPLOYMENT_ID )

aws cloudformation delete-stack --stack-name $STACK_NAME


