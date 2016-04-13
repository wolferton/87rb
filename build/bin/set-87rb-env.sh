#!/usr/bin/env bash

if ! [ -x "$(command -v aws)" ]; then
  echo "The aws command line tool needs to be installed before using 87Rb scripts"
  exit -1
fi

if [ -z ${HOME_87RB+x} ]
then
    echo "You must set the environment variable HOME_87RB before running this script"
    exit -1
else
    #Load the default set of variables that will be passed to CloudFormation
    source $HOME_87RB/build/DEFAULTS

    #If they exist, load any additional or overriden values specified by the user
    if [ -f $HOME_87RB/build/OVERRIDES ]
    then
        source $HOME_87RB/build/OVERRIDES
    fi

    #The AWS CloudFormation stack name for security groups for a given deployment
    function securityGroupStackName() {
        echo $V87RB_STACK_NAME_SECURITY_GROUPS-$1
    }

    #Convert an x.y.z version number into a dash-delimited form suitable for AWS resource names
    function awsSafeVersionNumber() {
        echo ${V87RB_VERSION//./-}
    }

    #The AWS CloudFormation stack name for an instance of 87Rb
    function 87rbStackName() {
        echo $V87RB_STACK_NAME_APPLICATION-$1-$( awsSafeVersionNumber )
    }

    function stackExistsAndReady() {
        result=$( aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --output text | grep $1 | wc -l )

        if [ $result = 1 ]
        then
            return 0
        else
            return 1
        fi
    }

    function checkSecurityGroupStackReady() {
        GROUP_NAME=$( securityGroupStackName $1 )

        if stackExistsAndReady $GROUP_NAME
        then
            return 0
        else
            echo "No CloudFormation stack containing security groups for deployment $DEPLOYMENT_ID exists or the stack is not ready to use yet."
            echo "Have you run create-security-groups.sh?"
            exit -1
        fi
    }

    function checkSourceBucketStackReady() {
        if stackExistsAndReady $V87RB_STACK_NAME_SOURCE_STORAGE
        then
            return 0
        else
            echo "No CloudFormation stack containing an S3 bucket for source storage does not exist or the stack is not ready to use yet."
            echo "Have you run create-source-bucket.sh?"
            exit -1
        fi
    }
fi
