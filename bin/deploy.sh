#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
echo "Finding S3 bucket details"

source $HOME_87RB/DEFAULTS

BUCKET=$(aws cloudformation describe-stacks --stack-name source-storage-87Rb --output json | python -c 'import sys, json; print json.load(sys.stdin)["Stacks"][0]["Outputs"][0]["OutputValue"]')

