FROM debian:stretch-slim

MAINTAINER creatorx jxz <creatorx@163.com>

ENV NGINX_VERSION 1.12.2

# update software
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y --no-install-recommends --no-install-suggests --fix-missing wget tar gcc make openssl libssl-dev libpcre3 libpcre3-dev zlib1g-dev && \
apt-get update && \
apt-get autoremove -y && \
apt-get clean && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/* 

# Nginx
RUN cd /usr/local/ && wget --no-check-certificate http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && tar xvzf nginx-${NGINX_VERSION}.tar.gz && rm -f nginx-${NGINX_VERSION}.tar.gz
# Naxsi
RUN cd /usr/local/ && wget --no-check-certificate https://github.com/nbs-system/naxsi/archive/master.tar.gz && tar xvzf master.tar.gz && rm master.tar.gz
 
# Compiling nginx with Naxsi
RUN cd /usr/local/nginx-${NGINX_VERSION} && ./configure \
         --conf-path=/etc/nginx/nginx.conf \
         --add-module=../naxsi-master/naxsi_src/ \
         --error-log-path=/usr/local/nginx/logs/error.log \
         --http-client-body-temp-path=/usr/local/nginx/temp/body \
         --http-fastcgi-temp-path=/usr/local/nginx/temp/fastcgi \
         --http-log-path=/usr/local/nginx/logs/access.log \
         --http-proxy-temp-path=/usr/local/nginx/temp/proxy \
         --lock-path=/var/lock/nginx.lock \
         --pid-path=/var/run/nginx.pid \
         --with-http_ssl_module \
         --without-mail_pop3_module \
         --without-mail_smtp_module \
         --without-mail_imap_module \
         --without-http_uwsgi_module \
         --without-http_scgi_module \
         --with-http_gzip_static_module \
         --prefix=/usr/local/
         
RUN cd /usr/local/nginx-${NGINX_VERSION} && make && make install

RUN cd /usr/local/nginx && mkdir temp && cd temp && mkdir fastcgi body proxy

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/naxsi.rules /etc/nginx/naxsi.rules
ADD conf/naxsi_core.rules /etc/nginx/naxsi_core.rules

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]