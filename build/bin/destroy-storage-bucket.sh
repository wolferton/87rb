#!/bin/bash
#Destroys the AWS CloudFormation stack containing the S3 bucket used for build artifact storage
source set-87rb-env.sh

checkSourceBucketStackReady
SOURCE_BUCKET_ID=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketId)

aws s3 rm --recursive s3://$SOURCE_BUCKET_ID/

aws cloudformation delete-stack --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE