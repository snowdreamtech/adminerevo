FROM snowdreamtech/php:8.4.2-fpm-alpine3.21

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Adminerevo Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Adminerevo on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/adminerevo" \
    org.opencontainers.image.base.name="snowdreamtech/adminerevo:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/adminerevo" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="4.8.4" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/adminerevo"

# Switch to the user
USER root

# Set the workdir
WORKDIR /root

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=0 

ENV ADMINEREVO_VERSION=4.8.4 \
    ADMINEREVO_SQLITE_PASSWORD='' \
    ADMINEREVO_PATH=/var/lib/nginx/html \
    ADMINEREVO_THEMES_PATH=/var/lib/nginx/html/designs \
    ADMINEREVO_PLUGINS_PATH=/var/lib/nginx/html/plugins \
    ADMINEREVO_DRIVERS_PATH=/var/lib/nginx/html/plugins/drivers \
    GITHUB_PROXY=https://gh-proxy.sn0wdr1am.com/

ARG GID=1000 \
    UID=1000  \
    USER=root \
    WORKDIR=/root

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    # setcap 'cap_net_bind_service=+ep' `which nginx`; \
    fi

COPY designs ${ADMINEREVO_THEMES_PATH}

RUN mkdir -p ${ADMINEREVO_PATH} \
    && mkdir -p ${ADMINEREVO_THEMES_PATH} \
    && mkdir -p ${ADMINEREVO_PLUGINS_PATH} \
    && mkdir -p ${ADMINEREVO_DRIVERS_PATH} \
    && wget https://github.com/adminerevo/adminerevo/releases/download/v${ADMINEREVO_VERSION}/adminer-${ADMINEREVO_VERSION}.php -O ${ADMINEREVO_PATH}/adminer.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/plugin.php -O ${ADMINEREVO_PLUGINS_PATH}/plugin.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/adminer.js.php -O ${ADMINEREVO_PLUGINS_PATH}/adminer.js.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/database-hide.php -O ${ADMINEREVO_PLUGINS_PATH}/database-hide.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/designs.php -O ${ADMINEREVO_PLUGINS_PATH}/designs.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-alter.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-alter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-bz2.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-bz2.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-date.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-date.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-json.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-json.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-xml.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-xml.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/dump-zip.php -O ${ADMINEREVO_PLUGINS_PATH}/dump-zip.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-calendar.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-calendar.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-foreign.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-foreign.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/edit-textarea.php -O ${ADMINEREVO_PLUGINS_PATH}/edit-textarea.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/enum-option.php -O ${ADMINEREVO_PLUGINS_PATH}/enum-option.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/enum-types.php -O ${ADMINEREVO_PLUGINS_PATH}/enum-types.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/file-upload.php -O ${ADMINEREVO_PLUGINS_PATH}/file-upload.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/foreign-system.php -O ${ADMINEREVO_PLUGINS_PATH}/foreign-system.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/frames.php -O ${ADMINEREVO_PLUGINS_PATH}/frames.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/import-from-dir.php -O ${ADMINEREVO_PLUGINS_PATH}/import-from-dir.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/json-column.php -O ${ADMINEREVO_PLUGINS_PATH}/json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-external.php -O ${ADMINEREVO_PLUGINS_PATH}/login-external.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-ip.php -O ${ADMINEREVO_PLUGINS_PATH}/login-ip.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-otp.php -O ${ADMINEREVO_PLUGINS_PATH}/login-otp.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-servers.php -O ${ADMINEREVO_PLUGINS_PATH}/login-servers.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-password-less.php -O ${ADMINEREVO_PLUGINS_PATH}/login-password-less.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-ssl.php -O ${ADMINEREVO_PLUGINS_PATH}/login-ssl.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/login-table.php -O ${ADMINEREVO_PLUGINS_PATH}/login-table.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/master-slave.php -O ${ADMINEREVO_PLUGINS_PATH}/master-slave.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/pretty-json-column.php -O ${ADMINEREVO_PLUGINS_PATH}/pretty-json-column.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/slugify.php -O ${ADMINEREVO_PLUGINS_PATH}/slugify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/sql-log.php -O ${ADMINEREVO_PLUGINS_PATH}/sql-log.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/struct-comments.php -O ${ADMINEREVO_PLUGINS_PATH}/struct-comments.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/tables-filter.php -O ${ADMINEREVO_PLUGINS_PATH}/tables-filter.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/tinymce.php -O ${ADMINEREVO_PLUGINS_PATH}/tinymce.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/translation.php -O ${ADMINEREVO_PLUGINS_PATH}/translation.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/version-noverify.php -O ${ADMINEREVO_PLUGINS_PATH}/version-noverify.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/wymeditor.php -O ${ADMINEREVO_PLUGINS_PATH}/wymeditor.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/clickhouse.php -O ${ADMINEREVO_DRIVERS_PATH}/clickhouse.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/firebird.php -O ${ADMINEREVO_DRIVERS_PATH}/firebird.php \
    && wget ${GITHUB_PROXY}https://raw.githubusercontent.com/adminerevo/adminerevo/v${ADMINEREVO_VERSION}/plugins/drivers/simpledb.php -O ${ADMINEREVO_DRIVERS_PATH}/simpledb.php \
    && chown -Rv nginx:nginx ${ADMINEREVO_PATH} 

# Switch to the user
USER nginx

# Set the workdir
WORKDIR ${ADMINEREVO_PATH}

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]