#!/bin/sh
set -e

# Random ADMINEREVO_SQLITE_PASSWORD Generator
if [ -z ${ADMINEREVO_SQLITE_PASSWORD} ]; then {
    ADMINEREVO_SQLITE_PASSWORD=$(openssl rand -base64 33)
    echo "ADMINEREVO_SQLITE_PASSWORD = ${ADMINEREVO_SQLITE_PASSWORD}"
}
fi

# index.php
cat >${ADMINEREVO_PATH}/index.php <<EOF
<?php
function adminer_object() {
    // required to run any plugin
    include_once "./plugins/plugin.php";

    // plugins autoloader
    foreach (glob("plugins/*.php") as \$filename) {
        include_once "./\$filename";
    }

    // designs autoloader
    \$designs = array();
	foreach (glob("designs/*", GLOB_ONLYDIR) as \$filename) {
        \$designs["\$filename/adminer.css"] = basename(\$filename);
    }
    
    // enable extra drivers just by including them
    include "./plugins/drivers/simpledb.php";
    include "./plugins/drivers/firebird.php";
    include "./plugins/drivers/clickhouse.php";
    
    \$adminer = new AdminerPlugin([]);

    \$plugins = array(
        // specify enabled plugins here
        // new AdminerDatabaseHide(array('information_schema' , 'mysql' , 'performance_schema' , 'sys')),    // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/database-hide.php
        new AdminerDesigns(\$designs),       // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/designs.php
        new AdminerDumpAlter(),       // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-alter.php
        new AdminerDumpBz2(),         // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-bz2.php
        new AdminerDumpDate(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-date.php
        new AdminerDumpJson(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-json.php
        new AdminerDumpXml(),         // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-xml.php
        new AdminerDumpZip(),         // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/dump-zip.php
        // new AdminerEditCalendar(),    // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/edit-calendar.php     
        new AdminerEditForeign(),     // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/edit-foreign.php    
        new AdminerEditTextarea(),    // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/edit-textarea.php    
        new AdminerEnumOption(),      // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/enum-option.php  
        new AdminerEnumTypes(),       // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/enum-types.php   
        new AdminerFileUpload("data/"),//https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/file-upload.php
        new AdminerForeignSystem(),   // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/foreign-system.php     
        //new AdminerFrames(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/frames.php    
        new AdminerImportFromDir(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/import-from-dir.php    
        new AdminerJsonColumn(),      // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/json-column.php  
        // new AdminerLoginOtp(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/login-otp.php
        // new AdminerLoginServers(),    // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/login-servers.php     
        // TODO: inline the result of password_hash() so that the password is not visible in source codes
		new AdminerLoginPasswordLess(password_hash("${ADMINEREVO_SQLITE_PASSWORD}", PASSWORD_DEFAULT)),// https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/login-password-less.php         
        // new AdminerLoginSsl(),        // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/login-ssl.php
        // new AdminerLoginTable(),      // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/login-table.php
        // new AdminerMasterSlave(),     // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/master-slave.php
        new AdminerPrettyJsonColumn(\$adminer),// https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/pretty-json-column.php
        new AdminerSlugify(),         // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/slugify.php
        new AdminerSqlLog(),          // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/sql-log.php
        new AdminerStructComments(),  // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/struct-comments.php
        new AdminerTablesFilter(),    // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/tables-filter.php
        // new AdminerTinymce(),         // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/tinymce.php
        new AdminerTranslation(),     // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/translation.php
        new AdminerVersionNoverify(), // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/version-noverify.php
        // new AdminerWymeditor(),       // https://raw.githubusercontent.com/adminerevo/adminerevo/master/plugins/wymeditor.php
    );
    
    /* It is possible to combine customization and plugins:
    class AdminerCustomization extends AdminerPlugin {
    }
    return new AdminerCustomization(\$plugins);
    */
    
    \$adminer->plugins = \$plugins;

    return \$adminer;
}

// include original Adminer or Adminer Editor
include "./adminer.php";
?>
EOF

# start nginx
/usr/sbin/nginx -c /etc/nginx/nginx.conf

#fpm
/usr/bin/php-fpm --fpm-config /etc/php/8.2/fpm/php-fpm.conf

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null &
    wait
    # sleep infinity & wait
fi
