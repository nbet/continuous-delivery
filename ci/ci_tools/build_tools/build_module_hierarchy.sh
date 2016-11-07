#!/bin/bash

BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
echo $BUILD_SHELL_DIR

if [ $# -eq 2 ]
then
    SUB_PROJECT_NAME=$1
    MVN_FLAG=1
elif [ $# -eq 1 ]
then
    SUB_PROJECT_NAME=$1
else
    echo "usage: build_module_sub.sh <SUB_PROJECT_NAME> [<MVN_FLAG>]"
    exit 1
fi

PROJECT_NAME=$JOB_NAME
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILD_SOURCE_DIR_PROJ=$BUILD_WORKSPACE/$PROJECT_NAME
BUILD_SOURCE_BACKUP=$BUILD_WORKSPACE/backup
mkdir -p $BUILD_SOURCE_BACKUP

mkdir -p  $BUILD_SOURCE_BACKUP/$SUB_PROJECT_NAME
out=`diff -r $BUILD_SOURCE_DIR_PROJ/$SUB_PROJECT_NAME $BUILD_SOURCE_BACKUP/$SUB_PROJECT_NAME`

if [ -n "$out" ]
then
  echo $out
  rm -rf $BUILD_SOURCE_BACKUP/$SUB_PROJECT_NAME
  cp -r $BUILD_SOURCE_DIR_PROJ/$SUB_PROJECT_NAME $BUILD_SOURCE_BACKUP/
  rm -rf $BUILD_WORKSPACE/$SUB_PROJECT_NAME 
  cp -r $BUILD_SOURCE_DIR_PROJ/$SUB_PROJECT_NAME $BUILD_WORKSPACE/
  if [ -n "$MVN_FLAG" ]
  then    
    $BUILD_SHELL_DIR/build_module_java.sh $SUB_PROJECT_NAME
  else
    $BUILD_SHELL_DIR/build_module_src.sh $SUB_PROJECT_NAME
  fi
fi
