#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
: ${1:?"You must provide a unique name for the deployment as the first argument to this script"}
source $HOME_87RB/build/DEFAULTS

if [ -f $HOME_87RB/build/OVERRIDES ]
then
	source $HOME_87RB/build/OVERRIDES
fi

DEPLOYMENT_NAME=$1
SECURITY_GROUP_STACK=$V87RB_STACK_NAME_SECURITY_GROUPS-$DEPLOYMENT_NAME

API_SG_ID=$(stack-output-value.sh $SECURITY_GROUP_STACK ApiSecurityGroupId)

BUCKET_ID=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketId)
BUCKET_URI=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketUri)


AWS_SAFE_VERSION=${V87RB_VERSION//./-}

STACK_NAME=$V87RB_STACK_NAME_APPLICATION-$DEPLOYMENT_NAME-$AWS_SAFE_VERSION
STACK_VARIABLES="ParameterKey=ApiHttpPort,ParameterValue=$V87RB_API_PORT ParameterKey=SourceStorageS3BucketUri,ParameterValue=$BUCKET_URI ParameterKey=SourceStorageS3BucketId,ParameterValue=$BUCKET_ID ParameterKey=87RbVersion,ParameterValue=$V87RB_VERSION ParameterKey=ApiSecurityGroupId,ParameterValue=$API_SG_ID"

if [ -n $V87RB_SSH_KEY_NAME ]
then
	STACK_VARIABLES="$STACK_VARIABLES ParameterKey=SshKeyName,ParameterValue=$V87RB_SSH_KEY_NAME"
fi

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/build/cloudformation/unified.json --parameters $STACK_VARIABLES --capabilities CAPABILITY_IAM