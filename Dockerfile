FROM snowdreamtech/php:8.1.29

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV ADMINEREVO_VERSION=4.8.4 \
    ADMINEREVO_PORT=8080 \
    ADMINEREVO_SQLITE_PASSWORD='' \
    ADMINEREVO_PATH=/usr/share/webapps/adminerevo \
    ADMINEREVO_PLUGINS_PATH=/usr/share/webapps/adminerevo/plugins \
    ADMINEREVO_DRIVERS_PATH=/usr/share/webapps/adminerevo/plugins/drivers

RUN mkdir -p ${ADMINEREVO_PATH} \
    && mkdir -p ${ADMINEREVO_PLUGINS_PATH} \
    && mkdir -p ${ADMINEREVO_DRIVERS_PATH} \
    && wget https://github.com/adminerevo/adminerevo/releases/download/v${ADMINEREVO_VERSION}/adminer-${ADMINEREVO_VERSION}.php -O ${ADMINEREVO_PATH}/adminer.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/plugin.php -O ${ADMINEREVO_PLUGINS_PATH}/plugin.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/adminer.js.php -O ${ADMINEREVO_PLUGINS_PATH}/adminer.js.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/database-hide.php -O ${ADMINEREVO_PLUGINS_PATH}/database-hide.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/designs.php -O ${ADMINEREVO_PLUGINS_PATH}/designs.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-alter.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-alter.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-bz2.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-bz2.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-date.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-date.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-json.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-json.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-xml.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-xml.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-zip.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-zip.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-calendar.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-calendar.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-foreign.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-foreign.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-textarea.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-textarea.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/enum-option.php -O ${ADMINEREVO_PLUGINS_PATH}/enum-option.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/enum-types.php -O ${ADMINEREVO_PLUGINS_PATH}/enum-types.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/file-upload.php -O ${ADMINEREVO_PLUGINS_PATH}/file-upload.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/foreign-system.php -O ${ADMINEREVO_PLUGINS_PATH}/foreign-system.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/frames.php -O ${ADMINEREVO_PLUGINS_PATH}/frames.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/import-from-dir.php -O ${ADMINEREVO_PLUGINS_PATH}/import-from-dir.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/json-column.php -O ${ADMINEREVO_PLUGINS_PATH}/json-column.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-external.php -O ${ADMINEREVO_PLUGINS_PATH}/login-external.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-ip.php -O ${ADMINEREVO_PLUGINS_PATH}/login-ip.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-otp.php -O ${ADMINEREVO_PLUGINS_PATH}/login-otp.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-servers.php -O ${ADMINEREVO_PLUGINS_PATH}/login-servers.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-password-less.php -O ${ADMINEREVO_PLUGINS_PATH}/login-password-less.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-ssl.php -O ${ADMINEREVO_PLUGINS_PATH}/login-ssl.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-table.php -O ${ADMINEREVO_PLUGINS_PATH}/login-table.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/master-slave.php -O ${ADMINEREVO_PLUGINS_PATH}/master-slave.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/pretty-json-column.php -O ${ADMINEREVO_PLUGINS_PATH}/pretty-json-column.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/slugify.php -O ${ADMINEREVO_PLUGINS_PATH}/slugify.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/sql-log.php -O ${ADMINEREVO_PLUGINS_PATH}/sql-log.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/struct-comments.php -O ${ADMINEREVO_PLUGINS_PATH}/struct-comments.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/tables-filter.php -O ${ADMINEREVO_PLUGINS_PATH}/tables-filter.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/tinymce.php -O ${ADMINEREVO_PLUGINS_PATH}/tinymce.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/translation.php -O ${ADMINEREVO_PLUGINS_PATH}/translation.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/version-noverify.php -O ${ADMINEREVO_PLUGINS_PATH}/version-noverify.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/wymeditor.php -O ${ADMINEREVO_PLUGINS_PATH}/wymeditor.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/clickhouse.php -O ${ADMINEREVO_DRIVERS_PATH}/clickhouse.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/firebird.php -O ${ADMINEREVO_DRIVERS_PATH}/firebird.php \
    && wget https://gh-proxy.sn0wdr1am.com/https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/simpledb.php -O ${ADMINEREVO_DRIVERS_PATH}/simpledb.php 
    


EXPOSE 8080

COPY designs /usr/share/webapps/adminerevo/designs

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["sh","-c","php -S 0.0.0.0:${ADMINEREVO_PORT} -t /usr/share/webapps/adminerevo"]