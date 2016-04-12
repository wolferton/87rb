#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
: ${1:?"You provide the unique name of the deployment to destroy"}

source $HOME_87RB/build/DEFAULTS

if [ -f $HOME_87RB/build/OVERRIDES ]
then
	source $HOME_87RB/build/OVERRIDES
fi

DEPLOYMENT_NAME=$1
AWS_SAFE_VERSION=${V87RB_VERSION//./-}

STACK_NAME=$V87RB_STACK_NAME_APPLICATION-$DEPLOYMENT_NAME-$AWS_SAFE_VERSION

echo "Smoke testing $STACK_NAME"

DEPLOY_HOST=$(stack-output-value.sh $STACK_NAME CombinedControlNodePublicDomain)

API_URI=$(stack-output-value.sh $STACK_NAME ApiUri)

echo "Checking API on $API_URI"
curl $API_URI/health-check

