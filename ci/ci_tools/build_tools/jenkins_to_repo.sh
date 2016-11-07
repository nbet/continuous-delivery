#!/usr/bin/env bash

#0. get shell original directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
echo $BUILD_SHELL_DIR

if [ $# -lt 3 ]
then
    echo "usage: copy_op_to_repo.sh repo_addr proj_name user/password [/var/www/html8080]"
    exit 1
else
    REPO_ADDR=$1
    PROJ_NAME=$2
    USER=`echo $3 | cut -d/ -f1`
    PASSWD=`echo $3 | cut -d/ -f2`
    DST_PATH=$4
fi

if [ ! -n $USER ]; then
	echo "USER is null"
    exit 1
elif [ ! -n $PASSWD ]; then
	echo "PASSWD is null"
    exit 1
else
    echo "USER:$USER PASSWD:$PASSWD"
fi

PROJ_NAME_CAPITAL=`echo $PROJ_NAME | tr a-z A-Z`

#1. get output directory
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILD_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_LATEST_DIR=$BUILD_ROOT_DIR/latest


if [ -z $DST_PATH ]; then
    DST_PATH='/var/www/html'
fi

expect $BUILD_SHELL_DIR/transfer.exp $BUILD_LATEST_DIR $REPO_ADDR $PROJ_NAME_CAPITAL $USER $PASSWD $DST_PATH


if [ $? -ne 0 ]
then
	echo "expect script return $?"
fi
echo "copy files to repo completed"
