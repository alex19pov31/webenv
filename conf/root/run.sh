#!/bin/bash

service mysqld start
service php54-php-fpm start
service varnish start
service nginx start
/bin/bash