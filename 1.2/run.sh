#!/bin/bash

check_mk -O
cmk -Ivp
# DO NOT DO RESTART
# check_mk -Rvp
check_mk -O

nagios3 -d /etc/nagios3/nagios.cfg

source /etc/apache2/envvars
# dirty ?
export APACHE_RUN_USER=nagios
export APACHE_RUN_GROUP=nagios
apache2

tail -f /var/log/apache2/access.log
