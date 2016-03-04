#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}


if ! hash aws 2>/dev/null; then
    echo "You must install and configure the AWS command line tools before running this script."
    exit
fi

STACK_NAME='source-storage-87Rb'

VERSION=$(<$HOME_87RB/VERSION)

CMD_OPTIONS=""

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://$HOME_87RB/cloudformation/source-bucket.json $CMD_OPTIONS




