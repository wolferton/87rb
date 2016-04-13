#!/bin/bash
source set-87rb-env.sh

checkSourceBucketStackReady
SOURCE_BUCKET_ID=$(stack-output-value.sh $V87RB_STACK_NAME_SOURCE_STORAGE SourceBucketId)

echo "Uploading to bucket $SOURCE_BUCKET_ID"

echo "Packaging source folders"

for COMPONENT in 87rb-api 87rb-ui 87rb-trigger
do
	FILE=$COMPONENT.tar.gz
	(cd $HOME_87RB && tar -zcf /tmp/$FILE $COMPONENT)
	aws s3 cp /tmp/$FILE s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/src/ --quiet
	rm /tmp/$FILE
done

#Static assets
(cd $HOME_87RB/87rb-ui && tar -zcf /tmp/static.tar.gz static)
aws s3 cp /tmp/static.tar.gz s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/ --quiet

#Quilt - TODO download from web
(cd $HOME_87RB/.. && tar -zcf /tmp/quilt.tar.gz quilt)
aws s3 cp /tmp/quilt.tar.gz s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/dependencies/ --quiet
rm /tmp/quilt.tar.gz

#PQL - TODO download from web
(cd $HOME_87RB/../../lib && tar -zcf /tmp/pq.tar.gz pq)
aws s3 cp /tmp/pq.tar.gz s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/dependencies/ --quiet
rm /tmp/pq.tar.gz

aws s3 cp $HOME_87RB/build/templates/build.sh s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/setup-web-server.sh s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/init.d s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/init-core-db.sh s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/lighttpd.conf s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/pg_hba.conf s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/templates/ --quiet
aws s3 cp $HOME_87RB/build/templates/config/87rb-api-parameters.json s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/config/ --quiet
aws s3 cp $HOME_87RB/build/templates/config/87rb-ui-parameters.json s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/config/ --quiet
aws s3 cp $HOME_87RB/build/templates/config/87rb-trigger-parameters.json s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/config/ --quiet

aws s3 cp $HOME_87RB/schema/87rb-core.sql s3://$SOURCE_BUCKET_ID/$V87RB_VERSION/schema/ --quiet


