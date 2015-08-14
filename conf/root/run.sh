#!/bin/bash

echo $type > /root/test.log
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-availble/$type /etc/nginx/sites-enabled/default
service mysqld start
service php56-php-fpm start
service varnish start
service nginx start
/bin/bash