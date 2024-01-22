FROM nginx:1.21.1
WORKDIR /work
COPY ./nginx-1.21.1.tar.gz /work
RUN cd /work && \
	 tar -zxf ./nginx-1.21.1.tar.gz && \
	 cd /work/nginx-1.22.1 && \
	#   ./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module
    ./configure --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules 