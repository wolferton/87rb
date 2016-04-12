#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}


if ! hash aws 2>/dev/null; then
    echo "You must install and configure the AWS command line tools before running this script."
    exit
fi

source $HOME_87RB/build/DEFAULTS

if [ -f $HOME_87RB/build/OVERRIDES ]
then
	source $HOME_87RB/build/OVERRIDES
fi

CMD_OPTIONS=""

aws cloudformation create-stack --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE --template-body file://$HOME_87RB/build/cloudformation/source-bucket.json $CMD_OPTIONS --output text




