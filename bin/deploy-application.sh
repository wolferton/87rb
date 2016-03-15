#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
: ${1:?"You must provide a toploogy as the first argument to this script"}
source $HOME_87RB/DEFAULTS

if [ -f $HOME_87RB/OVERRIDES ]
then
	source $HOME_87RB/OVERRIDES
fi


BUCKET_ID=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketId)
BUCKET_DOMAIN=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketDomainName)

TOPOLOGY=$1
AWS_SAFE_VERSION=${V87RB_VERSION//./-}

STACK_NAME=$V87RB_STACK_NAME_APPLICATION-$TOPOLOGY-$AWS_SAFE_VERSION
STACK_VARIABLES="ParameterKey=SourceStorageS3BucketDomain,ParameterValue=$BUCKET_DOMAIN ParameterKey=SourceStorageS3BucketId,ParameterValue=$BUCKET_ID ParameterKey=87RbVersion,ParameterValue=$V87RB_VERSION"

if [ -n $V87RB_SSH_KEY_NAME ]
then
	STACK_VARIABLES="$STACK_VARIABLES ParameterKey=SshKeyName,ParameterValue=$V87RB_SSH_KEY_NAME"
fi

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/cloudformation/$TOPOLOGY.json --parameters $STACK_VARIABLES --capabilities CAPABILITY_IAM