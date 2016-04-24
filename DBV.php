<?php

/**
 * Copyright (c) 2012 Victor Stanciu (http://victorstanciu.ro)
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @package DBV
 * @version 1.0.3
 * @author Victor Stanciu <vic.stanciu@gmail.com>
 * @link http://dbv.vizuina.com
 * @copyright Victor Stanciu 2012
 */
class DBV_Exception extends Exception
{

}

class DBV
{

    protected $_action = "index";
    protected $_adapter;
    protected $_log = array();

    public function authenticate()
    {
        if (isset($_SERVER['HTTP_AUTHORIZATION'])) {
            $authorization = $_SERVER['HTTP_AUTHORIZATION'];
        } else {
            if (function_exists('apache_request_headers')) {
                $headers = apache_request_headers();
                $authorization = $headers['HTTP_AUTHORIZATION'];
            }
        }

        list($_SERVER['PHP_AUTH_USER'], $_SERVER['PHP_AUTH_PW']) = explode(':', base64_decode(substr($authorization, 6)));
        if (strlen(DBV_USERNAME) && strlen(DBV_PASSWORD) && (!isset($_SERVER['PHP_AUTH_USER']) || !($_SERVER['PHP_AUTH_USER'] == DBV_USERNAME && $_SERVER['PHP_AUTH_PW'] == DBV_PASSWORD))) {
            header('WWW-Authenticate: Basic realm="DBV interface"');
            header('HTTP/1.0 401 Unauthorized');
            echo _('Access denied');
            exit();
        }
    }

    /**
     * @return DBV_Adapter_Interface
     */
    protected function _getAdapter()
    {
        if (!$this->_adapter) {
            $file = DBV_ROOT_PATH . DS . 'lib' . DS . 'adapters' . DS . DB_ADAPTER . '.php';
            if (file_exists($file)) {
                require_once $file;

                $class = 'DBV_Adapter_' . DB_ADAPTER;
                if (class_exists($class)) {
                    $adapter = new $class;
                    try {
                        $adapter->connect(DB_HOST, DB_PORT, DB_USERNAME, DB_PASSWORD, DB_NAME);
                        $this->_adapter = $adapter;
                    } catch (DBV_Exception $e) {
                        $this->error("[{$e->getCode()}] " . $e->getMessage());
                    }
                }
            }
        }

        return $this->_adapter;
    }

    public function dispatch()
    {
        //$this->_parseBinLogs();
        if (!file_exists(DBV_META_PATH.DS."myrevisionrun")) {
            file_put_contents(DBV_META_PATH."myrevisionrun", '');
        }
        if (!file_exists(DBV_META_PATH.DS."revision")) {
            file_put_contents(DBV_META_PATH."revision", '');
        }
        if (!file_exists(DBV_REVISIONS_PATH.DS."lastsaved")) {
            file_put_contents(DBV_REVISIONS_PATH.DS."lastsaved", json_encode(array()));
        }
        $action = $this->_getAction() . "Action";
        $this->$action();
    }

    public function _getBinlog(){

        $dateLastRun = file_get_contents(DBV_META_PATH . DS . 'myrevisionrun');

        $filesArr = explode("\n",trim(file_get_contents(BIN_LOG.".index")));

        /* no ficheiro index. MY_INITIALS_int = 0 default */
        $currRev = $this->_getCurrentRevision(); 

        /* dia de hoje a meia noite se nao houver revisoes nenhumas, ou data da ultima revisao implementada */
        $dateRev = $this->_getDateLastRev($currRev); 

        $t1 = explode("/", $filesArr[0]);
        $t2 = array_pop($t1);

        $binLogLoc = implode("/", $t1);
        $data = '';

        foreach (new DirectoryIterator($binLogLoc) as $fileInfo3) {

            $fntime = $fileInfo3->getMTime();
            
            $fn = $fileInfo3->getFilename();

            if (substr($fn,0,6) == 'binlog' && substr($fn,7) != 'index' && strtotime(trim($dateLastRun)) < $fntime) {

                $comm = "mysqlbinlog -h ".DB_HOST." -u ".DB_USERNAME." -p".DB_PASSWORD." --database=".DB_NAME." --result-file='".BINLOG_OUTPUT_FOLDER.DS.TMP_OUTPUT_FILE."' --start-datetime='".$dateRev."' ".$fn;
                exec($comm);
                $data .= file_get_contents(BINLOG_OUTPUT_FOLDER.DS.TMP_OUTPUT_FILE);
            }
        }

        // binlog.index
        return $data;

    }

    public function _parseBinLogs(){

        if (!file_exists(BINLOG_OUTPUT_FOLDER)) {
            mkdir(BINLOG_OUTPUT_FOLDER);
        }

        $data = $this->_getBinlog();

        if ($data == '') {
            $this->_json('');
        }

        $lastRev = $this->_getLastRev(); /* MY_INITIALS_int = 0 default */

        $lastRevIntTmp = explode("_", $lastRev);

        $lastRevInt = strval($lastRevIntTmp[1]);

        $str = implode("\n\n", $this->_parseOps($data));

        file_put_contents(DBV_META_PATH . DS . 'myrevisionrun', date("Y-m-d H:i:s"));

        mkdir(DBV_REVISIONS_PATH.DS.MY_INITIALS."_".($lastRevInt+1));

        $f = file_put_contents(DBV_REVISIONS_PATH.DS.MY_INITIALS."_".($lastRevInt+1).DS."rev".($lastRevInt+1).".sql", $str);

        $this->_setCurrentRevision(MY_INITIALS."_".($lastRevInt+1));

        $this->_json($f);
    }

    public function _getLastRev(){

        $lastRev = 0;
        foreach (new DirectoryIterator(DBV_REVISIONS_PATH.DS) as $fileInfo) {
            $fn = $fileInfo->getFilename();
            if (intval(substr($fn,3)) > intval(substr($lastRev,3))) {
                $lastRev = $fn;
            }
        }

        return $lastRev;

    }

    public function _getDateLastRev($curRev){

        if ($curRev == 0) {
            $t = date("Y-m-d H:i:s",strtotime(DEFAULT_REV_DATE));
            return $t;
        }else{
            $mTime = 0;
            foreach (new DirectoryIterator(DBV_REVISIONS_PATH.DS.$curRev) as $fileInfo) {
                $fn = $fileInfo->getFilename();
                if (substr($fn, -3) == 'sql' && $fileInfo->getMTime() > $mTime) {
                    $mTime = $fileInfo->getMTime();
                }
            }
            return date("Y-m-d H:i:s",$mTime);

        }
    }

    public function _parseOps($data=''){
        $dados = explode("/*!*/;", $data);

        $dataF = array();
        $flag = 0;

        $usedb = 0;

        $dataF[] = "use `".DB_NAME."`;";
        foreach ($dados as $key => $value) {
            $alt = stripos($value,"alter");
            $cre = stripos($value,"create");
            $dro = stripos($value,"drop");
            if ((($alt !== false && $alt >= 0) || ($cre !== false && $cre >= 0) || ($dro !== false && $dro >= 0))) {
                if ($key > 0 && strpos($dados[$key-1],"error_code") !== false) {
                    preg_match_all("error_code *= *[0-9]+", $dados[$key-1],$hitstmp);
                    if (intval($hitstmp[0][0]) == 0) {
                        $dataF[] = trim($value).";";
                    }
                }
            }
        }

        //$str = implode("\n\n", $dataF);

        //return $str;

        return $dataF;
    }

    public function indexAction()
    {
        if ($this->_getAdapter()) {
            $this->schema = $this->_getSchema();
            $this->revisions = $this->_getRevisions();
            $this->revision = $this->_getCurrentRevision();
        }

        $this->_view("index");
    }

    public function alteracoesAction(){

        if ($this->_isXMLHttpRequest()) {
            $this->_parseBinLogs();
        }
    }

    public function schemaAction()
    {
        $items = isset($_POST['schema']) ? $_POST['schema'] : array();

        if ($this->_isXMLHttpRequest()) {
            if (!count($items)) {
                return $this->_json(array('error' => __("You didn't select any objects")));
            }

            foreach ($items as $item) {
                switch ($_POST['action']) {
                    case 'create':
                        $this->_createSchemaObject($item);
                        break;
                    case 'export':
                        $this->_exportSchemaObject($item);
                        break;
                }
            }

            $return = array('messages' => array());
            foreach ($this->_log as $message) {
                $return['messages'][$message['type']][] = $message['message'];
            }

            $return['items'] = $this->_getSchema();

            $this->_json($return);
        }
    }

    public function revisionsAction()
    {
        $revisions = isset($_POST['revisions']) ? $_POST['revisions'] : array();
        $current_revision = $this->_getCurrentRevision();

        if (count($revisions)) {

            usort($revisions, function ($rev1,$rev2){
                $rev1Val = intval(substr($rev1, 3));
                $rev2Val = intval(substr($rev2, 3));
                if ($rev1Val > $rev2Val) {
                    return 1;
                }elseif ($rev1Val < $rev2Val) {
                    return -1;
                }else{
                    return 0;
                }
            });

            foreach ($revisions as $revision) {
                $files = $this->_getRevisionFiles($revision);

                if (count($files)) {
                    foreach ($files as $file) {
                        $file = DBV_REVISIONS_PATH . DS . $revision . DS . $file;
                        if (!$this->_runFile($file)) {
                            break 2;
                        }
                    }
                }

                if (intval(substr($revision,3)) > $current_revision) {
                    $this->_setCurrentRevision($revision);
                }
                $this->confirm(__("Executed revision #{revision}", array('revision' => "<strong>$revision</strong>")));
            }
        }

        if ($this->_isXMLHttpRequest()) {
            $return = array(
                'messages' => array(),
                'revision' => $this->_getCurrentRevision()
            );
            foreach ($this->_log as $message) {
                $return['messages'][$message['type']][] = $message['message'];
            }
            $this->_json($return);

        } else {
            $this->indexAction();
        }
    }


    public function saveRevisionFileAction()
    {
        $revision = $_POST['revision'];
        if (preg_match('/^[a-z0-9\._]+$/i', $_POST['file'])) {
            $file = $_POST['file'];
        } else {
            $this->_json(array(
                'error' => __("Filename #{file} contains illegal characters. Please contact the developer.", array('file' => $_POST['file']))
            ));
        }

        $path = DBV_REVISIONS_PATH . DS . $revision . DS . $file;
        
        if (!file_exists($path)) {
            $this->_404();
        }

        $content = $_POST['content'];

        if (!@file_put_contents($path, $content)) {
            $this->_json(array(
                'error' => __("Couldn't write file: #{path}<br />Make sure the user running DBV has adequate permissions.", array('path' => "<strong>$path</strong>"))
            ));
        }

        $lastSaved2 = json_decode(file_get_contents(DBV_REVISIONS_PATH.DS."lastsaved"),true);

        $lastSaved2[$revision] = date("Y-m-d H:i:s");

        file_put_contents(DBV_REVISIONS_PATH.DS."lastsaved", json_encode($lastSaved2));

        $this->_json(array('ok' => true, 'message' => __("File #{path} successfully saved!", array('path' => "<strong>$path</strong>"))));
    }

    protected function _createSchemaObject($item)
    {
        $file = DBV_SCHEMA_PATH . DS . "$item.sql";

        if (file_exists($file)) {
            if ($this->_runFile($file)) {
                $this->confirm(__("Created schema object #{item}", array('item' => "<strong>$item</strong>")));
            }
        } else {
            $this->error(__("Cannot find file for schema object #{item} (looked in #{schema_path})", array(
                'item' => "<strong>$item</strong>",
                'schema_path' => DBV_SCHEMA_PATH
            )));
        }
    }

    protected function _exportSchemaObject($item)
    {
        try {
            $sql = $this->_getAdapter()->getSchemaObject($item);

            $file = DBV_SCHEMA_PATH . DS . "$item.sql";

            if (@file_put_contents($file, $sql)) {
                $this->confirm(__("Wrote file: #{file}", array('file' => "<strong>$file</strong>")));
            } else {
                $this->error(__("Cannot write file: #{file}", array('file' => "<strong>$file</strong>")));
            }
        } catch (DBV_Exception $e) {
            $this->error(($e->getCode() ? "[{$e->getCode()}] " : '') . $e->getMessage());
        }
    }

    protected function _runFile($file)
    {
        $extension = strtolower(pathinfo($file, PATHINFO_EXTENSION));

        switch ($extension) {
            case 'sql':
                $content = file_get_contents($file);
                if ($content === false) {
                    $this->error(__("Cannot open file #{file}", array('file' => "<strong>$file</strong>")));
                    return false;
                }

                try {
                    $this->_getAdapter()->query($content);
                    return true;
                } catch (DBV_Exception $e) {
                    $this->error("[{$e->getCode()}] {$e->getMessage()} in <strong>$file</strong>");
                }
                break;
        }

        return false;
    }

    protected function _getAction()
    {
        if (isset($_GET['a'])) {
            $action = $_GET['a'];
            if (in_array("{$action}Action", get_class_methods(get_class($this)))) {
                $this->_action = $action;
            }
        }
        return $this->_action;
    }

    protected function _view($view)
    {
        $file = DBV_ROOT_PATH . DS . 'templates' . DS . "$view.php";
        if (file_exists($file)) {
            include($file);
        }
    }

    protected function _getSchema()
    {
        $return = array();
        $database = $this->_getAdapter()->getSchema();
        $disk = $this->_getDiskSchema();

        if (count($database)) {
            foreach ($database as $item) {
                $return[$item]['database'] = true;
            }
        }

        if (count($disk)) {
            foreach ($disk as $item) {
                $return[$item]['disk'] = true;
            }
        }

        ksort($return);
        return $return;
    }

    protected function _getDiskSchema()
    {
        $return = array();

        foreach (new DirectoryIterator(DBV_SCHEMA_PATH) as $file) {
            if ($file->isFile() && pathinfo($file->getFilename(), PATHINFO_EXTENSION) == 'sql') {
                $return[] = pathinfo($file->getFilename(), PATHINFO_FILENAME);
            }
        }

        return $return;
    }

    public function _parseFile($fileName = ''){
        if (count(explode("_", $fileName)) == 1) {
            return false;
        }else{
            $inic = substr($fileName, 0,2);
            $ver = substr($fileName, 3);
            if (!is_numeric($ver)) {
                return false;
            }else{
                return true;
            }    
        }
        
    }

    protected function _getRevisions()
    {
        $return = array();

        foreach (new DirectoryIterator(DBV_REVISIONS_PATH) as $file) {
            if ($file->isDir() && !$file->isDot() && $this->_parseFile($file->getBasename()) /*&& is_numeric($file->getBasename())*/) {
                $return[] = $file->getBasename();
            }
        }

        // REVER????
        usort($return, function($a,$b){
                if (intval(substr($a, 3)) == intval(substr($b, 3))) {
                    return 0;
                }else if (intval(substr($a, 3)) < intval(substr($b, 3)) ) {
                        return 1;
                }else if(intval(substr($a, 3)) > intval(substr($b, 3)) ){
                    return -1;
                }
            });
        //rsort($return, SORT_NUMERIC);
        return $return;
    }

    protected function _getLastRevisionRun()
    {
        $file = DBV_META_PATH . DS . 'myrevisionrun';
        $ver = strval(file_get_contents($file));
        if ($ver !== '') {
            return $ver;
        }else{
            return 0;
        }
    }

    protected function _getCurrentRevision()
    {
        $file = DBV_META_PATH . DS . 'revision';
        $ver = strval(file_get_contents($file));
        if ($ver !== '' && file_exists(DBV_REVISIONS_PATH.DS.$ver)) {
            return $ver;
        }else{
            return 0;
        }
    }

    protected function _setCurrentRevision($revision)
    {
        $file = DBV_META_PATH . DS . 'revision';
        if (!@file_put_contents($file, $revision)) {
            $this->error("Cannot write revision file");
        }
    }

    protected function _getRevisionFiles($revision)
    {
        $dir = DBV_REVISIONS_PATH . DS . $revision;
        $return = array();

        foreach (new DirectoryIterator($dir) as $file) {
            if ($file->isFile() && pathinfo($file->getFilename(), PATHINFO_EXTENSION) == 'sql') {
                $return[] = $file->getBasename();
            }
        }

        sort($return, SORT_REGULAR);
        return $return;
    }

    protected function _getRevisionFileContents($revision, $file)
    {
        $path = DBV_REVISIONS_PATH . DS . $revision . DS . $file;
        if (file_exists($path)) {
            return file_get_contents($path);
        }

        return false;
    }

    public function log($item)
    {
        $this->_log[] = $item;
    }

    public function error($message)
    {
        $item = array(
            "type" => "error",
            "message" => $message
        );
        $this->log($item);
    }

    public function confirm($message)
    {
        $item = array(
            "type" => "success",
            "message" => $message
        );
        $this->log($item);
    }

    protected function _404()
    {
        header('HTTP/1.0 404 Not Found', true);
        exit('404 Not Found');
    }

    protected function _json($data = array())
    {
        header("Content-type: text/x-json");
        echo (is_string($data) ? $data : json_encode($data));
        exit();
    }

    protected function _isXMLHttpRequest()
    {
        if ($_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
            return true;
        }

        if (function_exists('apache_request_headers')) {
            $headers = apache_request_headers();
            if ($headers['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest') {
                return true;
            }
        }

        return false;
    }

    /**
     * Singleton
     * @return DBV
     */
    static public function instance()
    {
        static $instance;
        if (!($instance instanceof self)) {
            $instance = new self();
        }
        return $instance;
    }

}