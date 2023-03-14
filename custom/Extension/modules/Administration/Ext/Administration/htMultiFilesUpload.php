<?php 
if(!defined('sugarEntry') || !sugarEntry) die('Not A Valid Entry Point');
$admin_option_defs = array();
$admin_option_defs['Administration']['LBL_MULTI_FILES_UPLOAD'] = array(
    'Administration',
    'LBL_MULTI_FILES_UPLOAD_LISCENCE',
    'LBL_MULTI_FILES_UPLOAD_LISCENCE_DESC',
    './index.php?module=htMultiFilesUploadLicenseAddon&action=license',
    'oauth-keys'
);
$admin_group_header[]= array('LBL_MULTI_FILES_UPLOAD','',false,$admin_option_defs, '');