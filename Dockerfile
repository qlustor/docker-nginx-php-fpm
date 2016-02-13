#BUILDS qlustor/nginx-php-fpm

FROM gliderlabs/alpine:3.3
MAINTAINER Team QLUSTOR <team@qlustor.com>

# Install runit
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >>/etc/apk/repositories \
 && apk-install --update ca-certificates                \
 && update-ca-certificates                              \
 && apk-install runit

# Install nginx-php-fpm
RUN apk-install --update nginx php php-fpm php-cli php-soap php-json && \
    sed -i \
        -e 's/group =.*/group = nginx/' \
        -e 's/user =.*/user = nginx/' \
        -e 's/listen\.owner.*/listen\.owner = nginx/' \
        -e 's/listen\.group.*/listen\.group = nginx/' \
        -e 's/error_log =.*/error_log = \/dev\/stdout/' \
        /etc/php/php-fpm.conf && \
    sed -i \
        -e '/open_basedir =/s/^/\;/' \
        /etc/php/php.ini && \
    rm -rf /var/www/*

ADD . /

EXPOSE 80 443
#VOLUME /var/www
ENTRYPOINT ["/sbin/runit-docker"]

