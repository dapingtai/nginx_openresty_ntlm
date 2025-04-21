ARG OPENRESTY_VERSION=1.25.3.2
# Using huber OpenResty base image
FROM openresty:latest
ARG OPENRESTY_VERSION=1.25.3.2

# Install builder tool and independencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        zlib1g-dev \
        libgeoip-dev \
        libpcre3 libpcre3-dev \
        openssl \
        libssl-dev \
        wget \
        git

# Download and compile nginx-ntlm-module
RUN cd /opt \
    && git clone https://github.com/gabihodoroaga/nginx-ntlm-module.git \
    && wget -O openresty.tar.gz https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz \
    && tar -xzvf openresty.tar.gz \
    && mv /opt/openresty-$OPENRESTY_VERSION /opt/openresty

RUN cd /opt/openresty \
    && ./configure --add-dynamic-module=/opt/nginx-ntlm-module \
    && make \
    && make install

# Using new compile OpenResty (Image resize)
FROM openresty:latest
COPY --from=0 /usr/local/openresty /usr/local/openresty

# Run OpenResty
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]