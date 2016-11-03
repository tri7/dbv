<?php

/**
 * Your database authentication information goes here
 * @see http://dbv.vizuina.com/documentation/
 */
define('DB_HOST', 'localhost');
define('DB_PORT', 3306);
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'root');
define('DB_NAME', 'abacus');

/*.bin-log executable location */
define('BINLOG_EXEC_LOC','/Applications/MAMP/Library/bin/');

/* bin-logs file location */
define('BIN_LOG', '/Applications/MAMP/logs/index');

/* Used for temporarily holding part of the binlog - FOLDER*/
define('BINLOG_OUTPUT_FOLDER',"/Users/pedrotduarte/Sites/db_tools/data/binlogs");

/* Used for temporarily holding part of the binlog - FILE*/
define('TMP_OUTPUT_FILE', "binlog_tmp.txt");

/* Your revisions will have MY_INITIALS as prefix before the version. 2 Char max */
define('MY_INITIALS', "PD");

/* For the purpose of importing and parsing the binlogs, it looks at last implemented revision " implementation" date . 
If there is none that it looks at this config item */
define('DEFAULT_REV_DATE','yesterday midnight');
/**
 * Authentication data for access to DBV itself
 * If you leave any of the two constants below blank, authentication will be disabled
 * @see http://dbv.vizuina.com/documentation/#optional-settings
 */
define('DBV_USERNAME', '');
define('DBV_PASSWORD', '');

/**
 * @see http://dbv.vizuina.com/documentation/#writing-adapters
 */
define('DB_ADAPTER', 'MySQL');

define('DS', DIRECTORY_SEPARATOR);
define('DBV_ROOT_PATH', dirname(__FILE__));
    
/**
 * Only edit this lines if you want to place your schema files in custom locations
 * @see http://dbv.vizuina.com/documentation/#optional-settings
 */
define('DBV_DATA_PATH', DBV_ROOT_PATH . DS . 'data');
define('DBV_SCHEMA_PATH', DBV_DATA_PATH . DS . 'schema');
define('DBV_REVISIONS_PATH', DBV_DATA_PATH . DS . 'revisions');
define('IMPREVS', DBV_REVISIONS_PATH.DS."impRevs.json");
define('DBV_META_PATH', DBV_DATA_PATH . DS . 'meta');

ini_set('magic_quotes_gpc', 'Off');
error_reporting(E_ALL ^ E_NOTICE);

/**
 * I18n support
 */
define('DBV_LANGUAGES_PATH', DBV_ROOT_PATH . DS . 'languages');
define('DEFAULT_LOCALE', 'en_US');
define('DEFAULT_ENCODING', 'UTF-8');
define('DEFAULT_DOMAIN', 'default');

putenv("LC_ALL=".DEFAULT_LOCALE);
setlocale(LC_ALL, DEFAULT_LOCALE);

bindtextdomain(DEFAULT_DOMAIN, DBV_LANGUAGES_PATH);
bind_textdomain_codeset(DEFAULT_DOMAIN, DEFAULT_ENCODING);
textdomain(DEFAULT_DOMAIN);