#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}

source $HOME_87RB/build/DEFAULTS

if [ -f $HOME_87RB/build/OVERRIDES ]
then
	source $HOME_87RB/build/OVERRIDES
fi

BUCKET=$(aws cloudformation describe-stacks --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE --output json | python -c 'import sys, json; print json.load(sys.stdin)["Stacks"][0]["Outputs"][0]["OutputValue"]')

aws s3 rm --recursive s3://$BUCKET/

aws cloudformation delete-stack --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE