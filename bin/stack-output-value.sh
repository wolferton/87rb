#!/bin/bash
aws cloudformation describe-stacks --stack-name $1 --output text | grep $2 | awk '{ for (i=NF; i>1; i--) printf("%s ",$i); print $1; }' | cut -f1 -d' '