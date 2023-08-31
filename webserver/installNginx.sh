#!/bin/bash

# sleep untill instance is ready
untill [[ -f /var/lib/cloud/instance/boot-finished ]]; do
    sleep 1
done

# install nginx
apt-get update
apt-get install nginx -y

# make sure nginx is started
service nginx start
#service nginx enable
