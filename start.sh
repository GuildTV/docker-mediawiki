#!/bin/sh

cd /src/maintenance
php update.php

#set nginx to use correct number of processes
procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes 5/worker_processes $procs/" /etc/nginx/nginx.conf
sed -i -e "s/VM_ENV production/VM_ENV $VM_ENV/" /etc/nginx/sites-enabled/default

# Start supervisord and services
/usr/bin/supervisord -n
