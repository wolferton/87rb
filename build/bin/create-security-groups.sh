#!/bin/bash
# Creates an AWS CloudFormation stack that contains the security groups used to control inbound
# and outbound traffic to and from a deployment of 87Rb.

USAGE="Usage: $( basename $0 ) deployment-id"
[ -z "$1" ] && echo $USAGE && exit 1

source set-87rb-env.sh

STACK_NAME=$( securityGroupStackName $1 )
STACK_VARIABLES="ParameterKey=ApiPort,ParameterValue=$V87RB_API_PORT ParameterKey=PublicUiPort,ParameterValue=$V87RB_PUBLIC_UI_PORT"

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/build/cloudformation/security-groups.json --parameters $STACK_VARIABLES
