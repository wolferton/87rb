#!/bin/bash

: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
: ${1:?"You must provide a unique name for the deployment as the first argument to this script"}
source $HOME_87RB/build/DEFAULTS

if [ -f $HOME_87RB/build/OVERRIDES ]
then
	source $HOME_87RB/build/OVERRIDES
fi

DEPLOYMENT_NAME=$1

STACK_NAME=$V87RB_STACK_NAME_SECURITY_GROUPS-$DEPLOYMENT_NAME


STACK_VARIABLES="ParameterKey=ApiPort,ParameterValue=$V87RB_API_PORT ParameterKey=PublicUiPort,ParameterValue=$V87RB_PUBLIC_UI_PORT"
aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/build/cloudformation/security-groups.json --parameters $STACK_VARIABLES
