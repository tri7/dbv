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
    protected $impRevs = array();

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
        if (!file_exists(DBV_META_PATH.DS.DB_NAME."_myrevisionrun")) {
            file_put_contents(DBV_META_PATH.DS.DB_NAME."_myrevisionrun", '');
        }
        if (!file_exists(DBV_META_PATH.DS.DB_NAME."_revision")) {
            file_put_contents(DBV_META_PATH.DB_NAME."_revision", '');
        }
        if (!file_exists(IMPREVS)) {
            file_put_contents(IMPREVS, json_encode(array()));
        }
        if (!file_exists(DBV_REVISIONS_PATH.DS.DB_NAME."_lastsaved")) {
            file_put_contents(DBV_REVISIONS_PATH.DS.DB_NAME."_lastsaved", json_encode(array()));
        }
        $action = $this->_getAction() . "Action";
        $this->impRevs = json_decode(file_get_contents(IMPREVS));
        $this->$action();
    }

    public function _getBinlog(){

        $dateLastRun = file_get_contents(DBV_META_PATH . DS .DB_NAME.'_myrevisionrun');

        if ($dateLastRun == '') {
            $dateLastRun = date("Y-m-d H:i:s",strtotime(DEFAULT_REV_DATE));
        }

        $startDateTime = " --start-datetime='".$dateLastRun."' ";

        $filesArr = explode("\n",trim(file_get_contents(BIN_LOG.".index")));

        /* no ficheiro index. MY_INITIALS_int = 0 default */
        $currRev = $this->_getCurrentRevision(); 

        /* dia de hoje a meia noite se nao houver revisoes nenhumas, ou data da ultima revisao implementada */
        //$dateRev = $this->_getDateLastRev($currRev); 

        $t1 = explode("/", $filesArr[0]);
        array_pop($t1);

        $binLogLoc = implode("/", $t1);

        $data = '';

        file_put_contents(BINLOG_OUTPUT_FOLDER.DS.TMP_OUTPUT_FILE, "");

        foreach (new DirectoryIterator($binLogLoc) as $fileInfo3) {

            $fntime = $fileInfo3->getMTime();
            
            $fn = $fileInfo3->getFilename();

            $bFile = substr(BIN_LOG, 0, -5).$fn;

            /*.REVER $dateLastRun < $fntime !!!!! */

            if (substr($fn,0,6) == 'binlog' && substr($fn,7) != 'index' && $dateLastRun < $fntime) {

                $comm = BINLOG_EXEC_LOC."mysqlbinlog -h ".DB_HOST." -u ".DB_USERNAME." -p".DB_PASSWORD." --database=".DB_NAME." --result-file='".BINLOG_OUTPUT_FOLDER.DS.TMP_OUTPUT_FILE."' --start-datetime='".$dateLastRun."' ".$bFile;

                $x = exec($comm);
                
                $data .= file_get_contents(BINLOG_OUTPUT_FOLDER.DS.TMP_OUTPUT_FILE);
            }
        }

        return $data;

    }


    /* Parses bin log and writes to file revision_ts.sql the sql queries in the format: DBname_INITIALS_TSAMP/revision_ts.sql */
    public function _parseBinLogs(){

        if (!file_exists(BINLOG_OUTPUT_FOLDER)) {
            mkdir(BINLOG_OUTPUT_FOLDER);
        }

        $data = $this->_getBinlog();

        if ($data == '') {
            $this->_json('');
        }

        //$lastRev = $this->_getLastRev(); /* MY_INITIALS_int = 0 default */


        $str = implode("\n\n", $this->_parseOps($data));

        if ($str != '') {
            file_put_contents(DBV_META_PATH . DS . DB_NAME.'_myrevisionrun', date("Y-m-d H:i:s"));

            $ts = date('YmdHis');

            /* REVER ts !!!! NOW() NAO E' NECESSARIAMENTE A DATA DE IMPLEMENTACAO NA BD */

            mkdir( DBV_REVISIONS_PATH.DS.DB_NAME."_".MY_INITIALS."_".$ts );

            $f = file_put_contents(DBV_REVISIONS_PATH.DS.DB_NAME."_".MY_INITIALS."_".$ts.DS."revision_".$ts.".sql", $str);

            /* Add to revision to array $this->impRevs */
            $xtmp = $this->impRevs;

            $xtmp[] = array('name' => DB_NAME."_".MY_INITIALS."_".$ts, 'date' => $ts);

            $this->impRevs = $xtmp;

            file_put_contents(IMPREVS, json_encode($this->impRevs),FILE_APPEND);

            $this->_setCurrentRevision(DB_NAME."_".MY_INITIALS."_".$ts);

            $this->_json($f);
        }else{
            $this->_json('');
        } 
    }


    /* REVER!! */
    /*public function _getLastRev(){

        $lastRev = 0;
        foreach (new DirectoryIterator(DBV_REVISIONS_PATH.DS) as $fileInfo) {
            $fn = $fileInfo->getFilename();
            if (intval(substr($fn,3)) > intval(substr($lastRev,3))) {
                $lastRev = $fn;
            }
        }

        return $lastRev;

    }*/

    /*public function _getDateLastRev($curRev){

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
    }*/

    public function _parseOps($data = ''){
        $dados = explode("/*!*/;", $data);
        $dataF = array();
        $flag = 0;

        foreach ($dados as $key => $value) {

            $alt = strpos($value,"ALTER");
            $cre = strpos($value,"CREATE");
            $dro = strpos($value,"DROP");

            if ((($alt !== false && $alt >= 0) || ($cre !== false && $cre >= 0) || ($dro !== false && $dro >= 0))) {
                $dataF[] = trim($value).";";
                /*if ($key > 0 && strpos($dados[$key-1],"error_code") !== false) {
                    preg_match_all("error_code *= *[0-9]+", $dados[$key-1],$hitstmp);
                    if (intval($hitstmp[0][0]) == 0) {
                        $dataF[] = trim($value).";";
                    }
                }*/
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
            $this->revisions = array_reverse($this->_getRevisions());
            
            $this->impRevs = $this->_getImpRevisions();
            $this->revision = $this->_getCurrentRevision();
        }

        $this->_view("index");
    }

    public function _getImpRevisions(){
        $data = json_decode(file_get_contents(IMPREVS));
        return $data;
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
        $revisions = isset($_POST['revisions']) ? array_reverse($_POST['revisions']) : array();
        $current_revision = $this->_getCurrentRevision();

        if (count($revisions)) {

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

                $this->_setCurrentRevision($revision);

                $this->confirm(__("Executed revision #{revision}", array('revision' => "<strong>$revision</strong>")));
            }

            //$this->writeHistFile($revisions);
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

        $lastSaved2 = json_decode(file_get_contents(DBV_REVISIONS_PATH.DS.DB_NAME."_lastsaved"),true);

        $lastSaved2[$revision] = date("Y-m-d H:i:s");

        file_put_contents(DBV_REVISIONS_PATH.DS.DB_NAME."_lastsaved", json_encode($lastSaved2));

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
         
                    $xtmp = $this->impRevs;
                    
                    $bn = explode("/", $file);

                    $xtmp[] = array('name'=>$bn[count($bn)-2],'date'=>Date('Ymdhis'));
                    
                    $this->impRevs = $xtmp;

                    file_put_contents(IMPREVS, json_encode($this->impRevs));

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

    /* $fileName = DB_MYINITIALS_TS1 */

    public function _parseFile($fileName = ''){
        $arr = explode("_", $fileName);
        if (count($arr) != 3) {
            return false;
        }else{
            $db = $arr[0];
            if ($db != DB_NAME) {
                return false;
            }
            return true;   
        }
    }

    function array_2_column($array = NULL, $key = NULL)
    {
        $output = array();

        foreach ($array as $value) {

            if (gettype($value) == 'object') {
                $val2 = (array) $value;
            }else{
                $val2 = $value;
            }

            $output[] = $val2[$key];

        }

        return $output;
    }

    protected function _getRevisions()
    {


        $return = array();

        foreach (new DirectoryIterator(DBV_REVISIONS_PATH) as $file) {

            if ($file->isDir() && !$file->isDot() && $this->_parseFile($file->getBasename())) {

                $return[] = $file->getBasename();
            }
        }

        $revsName = $this->array_2_column($this->impRevs,'name');
        $revsDate = $this->array_2_column($this->impRevs,'date');

        usort($return, function($a,$b) use ($revsName,$revsDate){

                $revs = $this->impRevs;

                $params_a = explode("_", $a);
                $params_b = explode("_", $b);

                $pos_a = array_search($a, $revsName );

                if ($params_a[1] == MY_INITIALS || ($params_a[1] != MY_INITIALS && $pos_a !== false)) {
                    $a_type = 'imprevs';
                    $a_dateImp = $revsDate[$pos_a];
                }else{
                    $a_type = 'remrevs';
                }

                $pos_b = array_search($b['name'], $revsName );

                if ($params_b[1] == MY_INITIALS || ($params_b[1] != MY_INITIALS && $pos_b !== false)) {
                    $b_type = 'imprevs';
                    $b_dateImp = $revsDate[$pos_b];
                }else{
                    $b_type = 'remrevs';
                }

                $c = array($a_type,$b_type);

                switch ($c) {
                    case array('imprevs','remrevs'):
                        return -1;
                        break;
                    case array('remrevs','imprevs'):
                        return 1;
                        break;
                    case array('imprevs','imprevs'):
                        if (strtotime($a_dateImp) < strtotime($b_dateImp)) {
                            return -1;
                        }else if(strtotime($a_dateImp) > strtotime($b_dateImp)){
                            return 1;
                        }else{
                            return 0;
                        }
                        break;
                    case array('remrevs','remrevs'):
                        if (strtotime($params_a[2]) < strtotime($params_b[2])) {
                            return -1;
                        }else if(strtotime($params_a[2]) > strtotime($params_b[2])){
                            return 1;
                        }else{
                            return 0;
                        }
                        break;
                }
            });

        //var_dump($return);

        return $return;

    }

    protected function _getLastRevisionRun()
    {
        $file = DBV_META_PATH . DS . DB_NAME.'_myrevisionrun';
        $ver = strval(file_get_contents($file));
        if ($ver !== '') {
            return $ver;
        }else{
            return 0;
        }
    }

    protected function _getCurrentRevision()
    {
        $file = DBV_META_PATH . DS . DB_NAME.'_revision';
        $ver = strval(file_get_contents($file));
        if ($ver !== '' && file_exists(DBV_REVISIONS_PATH.DS.$ver)) {
            return $ver;
        }else{
            return 0;
        }
    }

    protected function _setCurrentRevision($revision)
    {
        $file = DBV_META_PATH . DS . DB_NAME.'_revision';
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