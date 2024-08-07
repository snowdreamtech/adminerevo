#!/bin/sh
set -e

ADMINER_PATH=/usr/share/webapps/adminer
ADMINER_DESIGN_FILE=${ADMINER_PATH}/adminer.css
ADMINER_DESIGNS_PATH=${ADMINER_PATH}/designs

# adminer design
if [ ${ADMINER_DESIGN} == 'default' ]; then {
    rm ${ADMINER_DESIGN_FILE}
} else {
    if [ -f ${ADMINER_DESIGNS_PATH}/${ADMINER_DESIGN}/adminer.css ];then
        cp ${ADMINER_DESIGNS_PATH}/${ADMINER_DESIGN}/adminer.css ${ADMINER_PATH}
    fi
}
fi

# exec commands
exec "$@"
