#!/usr/bin/env sh

cd $(dirname $0)

if [ "$1" = 'nginx-php-fpm' ]; then

    # If we have a custom confiuration we should use it when starting nginx, otherwise use the default one. Here
    # we update the supervisord configuration with the custom parameter.

    if [ -f '/docker/config/nginx.conf' ]; then
        sed -i -e 's~\(command=nginx\).*$~\1 -c '"'"$(pwd)'/config/nginx.conf'"'"'~g' '/docker/config/supervisord/nginx.conf'
    else
        sed -i -e 's/\(command=nginx\).*$/\1/g' '/docker/config/supervisord/nginx.conf'
    fi

    supervisord --nodaemon --configuration="/docker/config/supervisord.conf"
fi
