#!/bin/bash
VERSION={{Version}}
WWW_DIR=/var/www/87rb-ui/$VERSION
mkdir -p $WWW_DIR

mv /home/87rb/tmp/static.tar.gz $WWW_DIR/
(cd $WWW_DIR && tar -xzf static.tar.gz && rm -f static.tar.gz)


chown -R 87rb:87rb /var/www/87rb-ui
mv /home/87rb/tmp/lighttpd.conf /etc/lighttpd/lighttpd.conf
