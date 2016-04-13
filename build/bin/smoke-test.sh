#!/bin/bash
#Performs basic connectivity tests against a deployment of 87Rb

USAGE="Usage: $( basename $0 ) deployment-id"
[ -z "$1" ] && echo $USAGE && exit 1

source set-87rb-env.sh

DEPLOYMENT_ID=$1
STACK_NAME=$( 87rbStackName $DEPLOYMENT_ID )

echo "Smoke testing $STACK_NAME"

DEPLOY_HOST=$(stack-output-value.sh $STACK_NAME CombinedControlNodePublicDomain)

API_URI=$(stack-output-value.sh $STACK_NAME ApiUri)

echo "Checking API on $API_URI"
curl $API_URI/health-check



