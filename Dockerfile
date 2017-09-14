FROM frolvlad/alpine-glibc:latest
LABEL maintainer="peter.teich@gmail.com"
LABEL description="Gogstash - A Logstash like log-forwarder in Go"

ENV GOGSTASH_VERSION 0.1.14
ENV DUMBINIT_VERSION 1.2.0

RUN set -x \
    && apk update && apk add --no-cache \
        openssl \
        dpkg \
        ca-certificates \
    && update-ca-certificates \
    && cd /tmp \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMBINIT_VERSION}/dumb-init_${DUMBINIT_VERSION}_${dpkgArch}" \
    && chmod +x /usr/local/bin/dumb-init \
    && wget -O /usr/local/bin/gogstash "https://github.com/tsaikd/gogstash/releases/download/${GOGSTASH_VERSION}/gogstash-Linux-x86_64" \
    && chmod +x /usr/local/bin/gogstash \
    && rm -rf /tmp/* \
    && mkdir /gogstash
    
WORKDIR /gogstash
VOLUME [ "/gogstash" ]    

ENTRYPOINT ["/usr/local/bin/dumb-init","/usr/local/bin/gogstash"]
