#!/bin/bash
export GOPATH={{GoHome}}
export INSTALL_HOME={{InstallHome}}
SRC_HOME={{SourceHome}}

mkdir -p $GOPATH
mkdir -p $INSTALL_HOME

for ARCHIVE in $SRC_HOME/*.tar.gz
do
  	FILE=$(basename $ARCHIVE)
    COMPONENT="${FILE%%.*}"
    rm -rf $INSTALL_HOME/$COMPONENT
    cp $ARCHIVE $INSTALL_HOME/
    (cd $INSTALL_HOME && tar -xzf $FILE)
    (cd $INSTALL_HOME/$COMPONENT && go install)
    rm $INSTALL_HOME/$FILE
done
