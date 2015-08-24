FROM  centos:6.6
MAINTAINER Nesterov Alexander <alex19pov31@gmail.com>

COPY conf/ /

RUN	yum update -y && \ 
	yum install git wget curl -y && \ 
	/bin/bash /root/bitrix-env.sh

EXPOSE 3306 80
ENTRYPOINT /bin/bash /root/run.sh