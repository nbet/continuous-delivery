#!/bin/bash

cat /etc/hosts
mkdir -p /tmp
alias cp='cp'
cp -f /etc/hosts /tmp/

addr=`ifconfig eth0 | grep "inet addr"|awk ' {print $2}'|cut -d : -f2`
echo $addr

sed -i "s/^127.0.0.1.*$/127.0.0.1 saltmaster.devops.company.com saltmaster localhost /g" hosts
sed -i "s/^$addr.*$/$addr saltmaster.devops.company.com saltmaster /g" hosts
sed -i '2,6d' hosts
cat /tmp/hosts

cp -f /tmp/hosts /etc/
cat /etc/hosts

