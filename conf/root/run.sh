#!/bin/bash

service mysqld start
service php56-php-fpm start
service varnish start
service nginx start
/bin/bash