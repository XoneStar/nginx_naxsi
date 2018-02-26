# docker for waf test

#### usage:
1. git clone https://github.com/XoneStar/nginx_naxsi.git
2. cd nginx_naxsi
3. docker build -t nginx_naxsi .
4. docker run --name nginx_naxsi -d -p 80:80 -v {yourself conf dir}/conf/nginx.conf:/etc/nginx/nginx.conf -v {yourself conf dir}/conf/naxsi_core.rules:/etc/nginx/naxsi_core.rules -v {yourself conf dir}/conf/naxsi.rules:/etc/nginx/naxsi.rules nginx-naxsi


#### or

1. docker pull creatorx/nginx-naxsi
2. docker run --name nginx_naxsi -d -p 80:80 -v {yourself conf dir}/conf/nginx.conf:/etc/nginx/nginx.conf -v {yourself conf dir}/conf/naxsi_core.rules:/etc/nginx/naxsi_core.rules -v {yourself conf dir}/conf/naxsi.rules:/etc/nginx/naxsi.rules creatorx/nginx-naxsi


#### waf test
1. modify/add/update {yourself conf dir}/conf/nginx.conf naxsi_core.rules naxsi.rules
2. docker restart [container-id]
