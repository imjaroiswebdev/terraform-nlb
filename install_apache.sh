#!/bin/bash -xe
cd /tmp
yum update -y
yum install -y httpd24
echo "Hello from the EC2 instance." > /var/www/html/index.html
sudo -u root service httpd start
