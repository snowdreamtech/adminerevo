FROM snowdreamtech/php:8.1.29

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV ADMINER_VERSION=4.8.1

RUN mkdir -p /usr/share/webapps/adminer \
    && wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /usr/share/webapps/adminer/index.php \
    && wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/editor-${ADMINER_VERSION}.php -O /usr/share/webapps/adminer/editor.php


EXPOSE 80

COPY designs /usr/share/webapps/adminer/designs

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["php","-S","0.0.0.0:80","-t","/usr/share/webapps/adminer"]