#!/bin/bash
#Deploys a instance of 87Rb running within a self contained AWS CloudFormation stack

USAGE="Usage: $( basename $0 ) deployment-id"
[ -z "$1" ] && echo $USAGE && exit 1

source set-87rb-env.sh

DEPLOYMENT_ID=$1

#Each deployment has a corresponding security group CloudFormation stack. Load the security group IDs from it.
checkSecurityGroupStackReady $DEPLOYMENT_ID

SECURITY_GROUP_STACK=$( securityGroupStackName $1 )
API_SG_ID=$(stack-output-value.sh $SECURITY_GROUP_STACK ApiSecurityGroupId)

#All deployments share a single bucket for build artifacts
checkSourceBucketStackReady

SOURCE_BUCKET_ID=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketId)
SOURCE_BUCKET_URI=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketUri)


STACK_NAME=$( 87rbStackName $DEPLOYMENT_ID )

#Parameters to pass to CloudFormation
STACK_PARAMETERS="ParameterKey=ApiHttpPort,ParameterValue=$V87RB_API_PORT ParameterKey=SourceStorageS3BucketUri,ParameterValue=$SOURCE_BUCKET_URI \
ParameterKey=SourceStorageS3BucketId,ParameterValue=$SOURCE_BUCKET_ID ParameterKey=87RbVersion,ParameterValue=$V87RB_VERSION \
ParameterKey=ApiSecurityGroupId,ParameterValue=$API_SG_ID  ParameterKey=PublicUiPort,ParameterValue=$V87RB_PUBLIC_UI_PORT"


#If an OVERRIDES variable exist specifiying the AWS keypair to use for admin, use it
if [ -n $V87RB_SSH_KEY_NAME ]
then
	STACK_PARAMETERS="$STACK_PARAMETERS ParameterKey=SshKeyName,ParameterValue=$V87RB_SSH_KEY_NAME"
fi

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/build/cloudformation/unified.json --parameters $STACK_PARAMETERS --capabilities CAPABILITY_IAM