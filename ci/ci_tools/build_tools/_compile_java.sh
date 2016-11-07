#!/usr/bin/env bash

#0. generate install directory
SERVICE_NAME=$1
PACKAGE_DIR=$2

#1. clean package
mkdir -p $PACKAGE_DIR
rm -rf $PACKAGE_DIR/*

#2. build package
mvn clean package

