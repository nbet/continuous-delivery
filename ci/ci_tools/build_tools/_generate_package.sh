#!/usr/bin/env bash


#0. get project name
SERVICE_NAME=$1
lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`
next_ver=$2
PACKAGE_DIR=$3

#1. invoke directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILDS_ROOT_DIR=$BUILD_WORKSPACE/builds
BUILD_OUTPUT_DIR=$BUILDS_ROOT_DIR/modules/$lowcase_project_name
BUILD_LATEST_DIR=$BUILDS_ROOT_DIR/latest


#2. generate tar.gz
cd $PACKAGE_DIR
JAR_FLAG=`ls .|grep .jar$`
WAR_FLAG=`ls .|grep .war$`
if [ -n "$JAR_FLAG" ]; then
  cp *.jar $BUILD_OUTPUT_DIR/$lowcase_project_name-$next_ver.jar
elif [ -n "$WAR_FLAG" ]; then
  cp *.war $BUILD_OUTPUT_DIR/$lowcase_project_name-$next_ver.war
else
  tar zcvf $lowcase_project_name-$next_ver.tar.gz ./$SERVICE_NAME --exclude=./$SERVICE_NAME/*.CI --exclude=./$SERVICE_NAME/.* --exclude=*.sh --exclude=$BUILD_SOURCE_DIR/.git*
  mv $lowcase_project_name-$next_ver.tar.gz $BUILD_OUTPUT_DIR/
fi

if [ $? -ne 0 ]; then
  echo "copy binary tgz out -- failure."
  exit 1
fi
cd -


#3. genetare latest symbolic
cd $BUILD_LATEST_DIR
echo "update latest tar info"
if [ -n "$JAR_FLAG" ]; then
  MATCH_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-*.jar
  rm -f $MATCH_TAR
  LATEST_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-$next_ver.jar
  echo "ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.jar $LATEST_TAR"
  ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.jar $LATEST_TAR
elif [ -n "$WAR_FLAG" ]; then
  MATCH_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-*.war
  rm -f $MATCH_TAR
  LATEST_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-$next_ver.war
  echo "ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.war $LATEST_TAR"
  ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.war $LATEST_TAR
else
  MATCH_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-*.tar.gz
  rm -f $MATCH_TAR
  LATEST_TAR=$BUILD_LATEST_DIR/$lowcase_project_name-$next_ver.tar.gz
  echo "ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.tar.gz $LATEST_TAR"
  ln -s ../modules/$SERVICE_NAME/$lowcase_project_name-$next_ver.tar.gz $LATEST_TAR
fi
cd -


