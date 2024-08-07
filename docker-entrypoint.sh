#!/bin/sh
set -e

ADMINER_PATH=/usr/share/webapps/adminer
ADMINER_DESIGN_FILE=${ADMINER_PATH}/adminer.css
ADMINER_DESIGNS_PATH=${ADMINER_PATH}/designs

# adminer design
if [ ${ADMINER_DESIGN} == 'default' ]; then {
    rm ${ADMINER_DESIGN_FILE}
} else {
    if [ -f ${ADMINER_DESIGNS_PATH}/${ADMINER_DESIGN}/adminer.css ]; then
        cp ${ADMINER_DESIGNS_PATH}/${ADMINER_DESIGN}/adminer.css ${ADMINER_PATH}
    fi
}
fi

# index.php
cat >${ADMINER_PATH}/index.php <<EOF
<?php
function adminer_object() {
    // required to run any plugin
    include_once "./plugins/plugin.php";
    
    // autoloader
    foreach (glob("plugins/*.php") as $filename) {
        include_once "./$filename";
    }
    
    // enable extra drivers just by including them
    //~ include "./plugins/drivers/simpledb.php";
    
    $plugins = array(
        // specify enabled plugins here
        new AdminerDatabaseHide(),    // https://raw.githubusercontent.com/vrana/adminer/master/plugins/database-hide.php
        new AdminerDesigns(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/designs.php
        new AdminerDumpAlter(),       // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-alter.php
        new AdminerDumpBz2(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-bz2.php
        new AdminerDumpDate(),        // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-date.php
        new AdminerDumpJson(),        // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-json.php
        new AdminerDumpXml(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-xml.php
        new AdminerDumpZip(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/dump-zip.php
        new AdminerEditCalendar(),    // https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-calendar.php     
        new AdminerEditForeign(),     // https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-foreign.php    
        new AdminerEditTextarea(),    // https://raw.githubusercontent.com/vrana/adminer/master/plugins/edit-textarea.php    
        new AdminerEnumOption(),      // https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-option.php  
        new AdminerEnumTypes(),       // https://raw.githubusercontent.com/vrana/adminer/master/plugins/enum-types.php   
        new AdminerFileUpload("data/"),//https://raw.githubusercontent.com/vrana/adminer/master/plugins/file-upload.php
        new AdminerForeignSystem(),   // https://raw.githubusercontent.com/vrana/adminer/master/plugins/foreign-system.php     
        //new AdminerFrames(),        // https://raw.githubusercontent.com/vrana/adminer/master/plugins/frames.php    
        new AdminerJsonColumn(),      // https://raw.githubusercontent.com/vrana/adminer/master/plugins/json-column.php  
        new AdminerLoginOtp(),        // https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-otp.php
        new AdminerLoginServers(),    // https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-servers.php     
        new AdminerLoginPasswordLess(),// https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-password-less.php         
        new AdminerLoginSsl(),        // https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-ssl.php
        new AdminerLoginTable(),      // https://raw.githubusercontent.com/vrana/adminer/master/plugins/login-table.php
        new AdminerMasterSlave(),     // https://raw.githubusercontent.com/vrana/adminer/master/plugins/master-slave.php
        new AdminerPrettyJsonColumn(),// https://raw.githubusercontent.com/vrana/adminer/master/plugins/pretty-json-column.php
        new AdminerSlugify(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/slugify.php
        new AdminerSqlLog(),          // https://raw.githubusercontent.com/vrana/adminer/master/plugins/sql-log.php
        new AdminerStructComments(),  // https://raw.githubusercontent.com/vrana/adminer/master/plugins/struct-comments.php
        new AdminerTablesFilter(),    // https://raw.githubusercontent.com/vrana/adminer/master/plugins/tables-filter.php
        new AdminerTinymce(),         // https://raw.githubusercontent.com/vrana/adminer/master/plugins/tinymce.php
        new AdminerTranslation(),     // https://raw.githubusercontent.com/vrana/adminer/master/plugins/translation.php
        new AdminerVersionNoverify(), // https://raw.githubusercontent.com/vrana/adminer/master/plugins/version-noverify.php
        new AdminerWymeditor(),       // https://raw.githubusercontent.com/vrana/adminer/master/plugins/wymeditor.php
    );
    
    /* It is possible to combine customization and plugins:
    class AdminerCustomization extends AdminerPlugin {
    }
    return new AdminerCustomization($plugins);
    */
    
    return new AdminerPlugin($plugins);
}

// include original Adminer or Adminer Editor
include "./adminer.php";
?>
EOF

# exec commands
exec "$@"
