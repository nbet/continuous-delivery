#!/usr/bin/env bash

#0. generate directory
BUILD_SHELL_DIR="$( cd "$( dirname "$0"  )" && pwd  )"
echo $BUILD_SHELL_DIR


#1. get project name
SERVICE_NAME=$1
lowcase_project_name=`echo $SERVICE_NAME | tr A-Z a-z`


#2. generate directory
BUILD_WORKSPACE=$BUILD_SHELL_DIR/..
BUILDS_ROOT_DIR=$BUILD_WORKSPACE/builds
mkdir -p $BUILDS_ROOT_DIR

BUILD_LATEST_DIR=$BUILDS_ROOT_DIR/latest
mkdir -p $BUILD_LATEST_DIR
BUILD_LATEST_SHA512_DIR=$BUILDS_ROOT_DIR/latest/sha512
mkdir -p $BUILD_LATEST_SHA512_DIR
BUILD_LATEST_CONFIG_DIR=$BUILDS_ROOT_DIR/latest/config
mkdir -p $BUILD_LATEST_CONFIG_DIR

BUILD_OUTPUT_DIR=$BUILDS_ROOT_DIR/modules/$lowcase_project_name
mkdir -p $BUILD_OUTPUT_DIR

BUILD_GIT_DIR=$BUILDS_ROOT_DIR/git
mkdir -p $BUILD_GIT_DIR

BUILD_CONFIG_OUTPUT_DIR=$BUILDS_ROOT_DIR/configs/$lowcase_project_name
mkdir -p $BUILD_CONFIG_OUTPUT_DIR

