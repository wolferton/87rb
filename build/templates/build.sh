#!/bin/bash
export GOPATH={{GoPath}}
export INSTALL_HOME={{InstallHome}}
SRC_HOME={{SourceHome}}
export PATH=$PATH:$GOPATH/bin
DEPS_DIR=$SRC_HOME/../deps

mkdir -p $GOPATH
mkdir -p $INSTALL_HOME

#TODO Remove relative paths
mv $DEPS_DIR/quilt.tar.gz $INSTALL_HOME/../
(cd $INSTALL_HOME/.. && tar -xzf quilt.tar.gz && rm -f quilt.tar.gz)
export QUILT_HOME=$INSTALL_HOME/../quilt
(cd $QUILT_HOME/cmd/quilt-bindings && go install)

GO_LIB_DIR=$INSTALL_HOME/../../lib
mkdir $GO_LIB_DIR
mv $DEPS_DIR/pq.tar.gz $GO_LIB_DIR/
(cd $GO_LIB_DIR && tar -xzf pq.tar.gz && rm -f pq.tar.gz)

for ARCHIVE in $SRC_HOME/*.tar.gz
do
  	FILE=$(basename $ARCHIVE)
    COMPONENT="${FILE%%.*}"
    rm -rf $INSTALL_HOME/$COMPONENT
    cp $ARCHIVE $INSTALL_HOME/
    (cd $INSTALL_HOME && tar -xzf $FILE)
    mv $SRC_HOME/../tmp/$COMPONENT-parameters.json $INSTALL_HOME/$COMPONENT/resource/config/parameters.json
    (cd $INSTALL_HOME/$COMPONENT && quilt-bindings && go install)
    rm $INSTALL_HOME/$FILE
done

chown 87rb:87rb $GOPATH
