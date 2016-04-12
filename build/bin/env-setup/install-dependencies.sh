#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root/sudo"
  exit
fi

OS_PACKAGES='golang python-pip'
PIP_PACKAGES='boto3 awscli'

if hash apt-get 2>/dev/null; then
    COMMAND='apt-get install'
else
    echo "No supported package manager available"
    exit
fi

$COMMAND $OS_PACKAGES
pip install $PIP_PACKAGES

