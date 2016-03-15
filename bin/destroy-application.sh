#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
: ${1:?"You provide the topology of the deployment to destroy"}

source $HOME_87RB/DEFAULTS

TOPOLOGY=$1
AWS_SAFE_VERSION=${V87RB_VERSION//./-}

STACK_NAME=$V87RB_STACK_NAME_APPLICATION-$TOPOLOGY-$AWS_SAFE_VERSION

aws cloudformation delete-stack --stack-name $STACK_NAME 