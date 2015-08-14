FROM  centos:6.6
MAINTAINER Nesterov Alexander <alex19pov31@gmail.com>

RUN	rpm -Uvh http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm && \ 
	yum update -y && \ 
	yum install nginx -y && \ 
	yum install epel-release wget curl -y && \ 
	rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi && \
	rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \ 
	yum update -y && \ 
	yum --enablerepo=remi install git mc mysql-server mysql-client varnish -y && \ 
	yum --enablerepo=remi install php56 php56-php-cli php56-php-fpm php56-php-opcache php56-php-apcu php56-php-phalcon2 -y && \ 
	cd /root && \ 
	git clone https://github.com/phalcon/phalcon-devtools.git && \ 
	ln -s /root/phalcon-devtools/phalcon.php /usr/bin/phalcon && \ 
	chmod ugo+x /usr/bin/phalcon && \ 
	curl -sS https://getcomposer.org/installer | php56 -- --install-dir=/usr/local/bin --filename=composer && \
	ln -s /opt/remi/php56/root/usr/bin/php /usr/bin/php

COPY conf/ /
EXPOSE 3306 80
ENTRYPOINT /bin/bash /root/run.sh