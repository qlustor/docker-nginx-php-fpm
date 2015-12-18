MAINTAINER Team QLUSTOR <team@qlustor.com>
FROM alpine:3.2

# Install supervisord
RUN apk --update add supervisor && \
    rm -rf /var/cache/apk/*

# Install nginx-php-fpm
RUN apk --update add nginx php php-fpm php-cli php-soap php-json && \
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
    rm -rf /var/www/* && \
    rm -rf /var/cache/apk/*

ADD . /

EXPOSE 80 443
VOLUME /var/www
ENTRYPOINT supervisord --nodaemon --configuration="/etc/supervisord.conf"

