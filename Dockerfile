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
	yum --enablerepo=remi install php54 php54-php-cli php54-php-fpm php54-php-opcache php54-php-apcu php54-php-mysqlnd php54-php-mbstring php54-php-gd php54-php-mcrypt -y && \ 
	cd /root && \ 
	curl -sS https://getcomposer.org/installer | php54 -- --install-dir=/usr/local/bin --filename=composer && \
	ln -s /opt/remi/php54/root/usr/bin/php /usr/bin/php && \
	mkdir /tmp/php && chown -R nginx:nginx /tmp/php && \
	chown -R nginx:nginx /opt/remi/php54/root/var/lib/php/session && \
	chown -R nginx:nginx /opt/remi/php54/root/var/lib/php/wsdlcache

COPY conf/ /
EXPOSE 3306 80
ENTRYPOINT /bin/bash /root/run.sh