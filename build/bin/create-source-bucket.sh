#!/bin/bash
#Creates an AWS S3 bucket for storing artifacts (source code, templates etc) that will be used by
#CloudFormation to build 87Rb components.
source set-87rb-env.sh

aws cloudformation create-stack --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE --template-body file://$HOME_87RB/build/cloudformation/source-bucket.json --output text




