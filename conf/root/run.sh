#!/bin/bash

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-availble/$type /etc/nginx/sites-enabled/default
service mysqld start
service php56-php-fpm start
service varnish start
service nginx start
#chown -R nginx:nginx /var/www
/bin/bash