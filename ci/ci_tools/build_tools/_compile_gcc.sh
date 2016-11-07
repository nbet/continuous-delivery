#!/usr/bin/env bash

#0. generate install directory
SERVICE_NAME=$1
PACKAGE_DIR=$2

#1. clean package
CMAKE_INSTALL_PREFIX=$PACKAGE_DIR/$SERVICE_NAME
mkdir -p $CMAKE_INSTALL_PREFIX
rm -rf $CMAKE_INSTALL_PREFIX/*
rm -rf CMakeCache.txt  CMakeFiles

#2. build package
#2.1 cmake
cmake -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX -DCPACK_PACKAGING_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX  ./
if [ $? -ne 0 ];then
	echo "cmake -- failure."	
	exit 1
fi


#2.2 make
make
if [ $? -ne 0 ];then
	echo "make -- failure."	
	exit 1
fi


#2.3 make install
make install
if [ $? -ne 0 ];then
	echo "make install -- failure."
	exit 1
fi

