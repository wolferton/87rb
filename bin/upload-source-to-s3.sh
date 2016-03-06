#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
source $HOME_87RB/DEFAULTS

cat $HOME_87RB/DEFAULTS

echo "Finding S3 bucket details"

BUCKET=$(aws cloudformation describe-stacks --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE --output json | python -c 'import sys, json; print json.load(sys.stdin)["Stacks"][0]["Outputs"][0]["OutputValue"]')
echo $BUCKET

echo "Packaging source folders"

for COMPONENT in api ui trigger
do
	FILE=87rb-$COMPONENT-$V87RB_VERSION.tar.gz
	(cd /tmp && tar -zcf $FILE $HOME_87RB/$COMPONENT)
	aws s3 cp /tmp/$FILE s3://$BUCKET/
done
