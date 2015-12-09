FROM alpine:3.2
MAINTAINER Leigh Phillips <neurocis@qlustor.com>

ADD . /docker
RUN /docker/build.sh

EXPOSE 80 443
VOLUME /docker/config

CMD ["nginx-php-fpm"]
ENTRYPOINT ["/docker/entrypoint.sh"]

