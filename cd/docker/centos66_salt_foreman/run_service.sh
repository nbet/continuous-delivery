#!/bin/bash

service postgresql initdb
service postgresql restart
service httpd restart
service foreman restart 
service foreman-proxy restart
service salt-master restart
service salt-api restart
service foreman-tasks restart

