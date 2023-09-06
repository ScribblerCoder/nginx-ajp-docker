FROM debian:bullseye-slim as build

RUN apt update && apt install libpcre3-dev wget git make gcc g++ zlib1g-dev -y && \
	wget https://nginx.org/download/nginx-1.21.3.tar.gz && \
    tar -xzvf nginx-1.21.3.tar.gz && \
    git clone https://github.com/dvershinin/nginx_ajp_module.git && \
    cd nginx-1.21.3 && \
    ./configure --add-module=`pwd`/../nginx_ajp_module --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules && \
    make && \
    make install && \
    nginx -V

FROM debian:bullseye-slim

COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build /etc/nginx/logs/ /etc/nginx/logs/

COPY nginx.conf /etc/nginx/conf/nginx.conf

EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
