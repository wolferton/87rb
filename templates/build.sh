#!/bin/bash
export GOPATH={{GoPath}}
export INSTALL_HOME={{InstallHome}}
SRC_HOME={{SourceHome}}
export PATH=$PATH:$GOPATH/bin

mkdir -p $GOPATH
mkdir -p $INSTALL_HOME

mv $SRC_HOME/../deps/quilt.tar.gz $INSTALL_HOME/../
(cd $INSTALL_HOME/.. && tar -xzf quilt.tar.gz)
export QUILT_HOME=$INSTALL_HOME/../quilt
(cd $QUILT_HOME && go install)

for ARCHIVE in $SRC_HOME/*.tar.gz
do
  	FILE=$(basename $ARCHIVE)
    COMPONENT="${FILE%%.*}"
    rm -rf $INSTALL_HOME/$COMPONENT
    cp $ARCHIVE $INSTALL_HOME/
    (cd $INSTALL_HOME && tar -xzf $FILE)
    mv $SRC_HOME/../tmp/$COMPONENT-parameters.json $INSTALL_HOME/$COMPONENT/conf/parameters.json
    (cd $INSTALL_HOME/$COMPONENT && quilt bind && go install)
    rm $INSTALL_HOME/$FILE
done
