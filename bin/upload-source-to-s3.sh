#!/bin/bash
: ${HOME_87RB:?"You must set the HOME_87RB environment variable before running this script"}
source $HOME_87RB/DEFAULTS

echo "Finding S3 bucket details"

BUCKET=$(aws cloudformation describe-stacks --stack-name $V87RB_STACK_NAME_SOURCE_STORAGE --output json | python -c 'import sys, json; print json.load(sys.stdin)["Stacks"][0]["Outputs"][0]["OutputValue"]')
echo "Uploading to bucket $BUCKET"

echo "Packaging source folders"

for COMPONENT in 87rb-api 87rb-ui 87rb-trigger
do
	FILE=$COMPONENT.tar.gz
	(cd $HOME_87RB && tar -zcf /tmp/$FILE $COMPONENT)
	aws s3 cp /tmp/$FILE s3://$BUCKET/$V87RB_VERSION/src/ --quiet
	rm /tmp/$FILE
done


(cd $HOME_87RB/.. && tar -zcf /tmp/quilt.tar.gz quilt)
aws s3 cp /tmp/quilt.tar.gz s3://$BUCKET/$V87RB_VERSION/dependencies/ --quiet
rm /tmp/quilt.tar.gz

aws s3 cp $HOME_87RB/templates/build.sh s3://$BUCKET/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/templates/init.d s3://$BUCKET/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/templates/init-core-db.sh s3://$BUCKET/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/templates/pg_hba.conf s3://$BUCKET/$V87RB_VERSION/templates/ --quiet

aws s3 cp $HOME_87RB/schema/87rb-core.sql s3://$BUCKET/$V87RB_VERSION/schema/ --quiet