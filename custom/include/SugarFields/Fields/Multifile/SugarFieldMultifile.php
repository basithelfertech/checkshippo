<?php
require_once('include/SugarFields/Fields/Base/SugarFieldBase.php');
class SugarFieldMultifile extends SugarFieldBase {
    public function save(&$bean, $params, $field, $vardef, $prefix = ''){
    	$finalInput = array();
        $fieldName = str_replace('_','',$field);
    	foreach ($_REQUEST[$fieldName.'dropzone'] as $key => $fileJson) {
    		if(empty($fileJson) || $fileJson == ""){
    			continue;
    		}
    		$fileArray    = explode("::", $fileJson);
    		$finalInput[] = array("file_id" => $fileArray[0], "file_name" => $fileArray[1], "file_type" => $fileArray[2], "file_size" => $fileArray[3]);
    	}
        $bean->$field = base64_encode(json_encode($finalInput));
    }
    public function getEditViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex) {
        require_once('modules/htMultiFilesUploadLicenseAddon/license/htMultiFilesUploadOutfittersLicense.php');
		$validate_license = htMultiFilesUploadOutfittersLicense::isValid('htMultiFilesUploadLicenseAddon');
        if($validate_license === true){
            return parent::getEditViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex);
        }else{
            return "<a class='btn btn-danger lis-dito' href='index.php?module=htMultiFilesUploadLicenseAddon&action=license'>Please Configure License.</a>{literal}<script>$('.lis-dito').parent().parent().find('div').first().hide();</script>{/literal}";
        }
    }
    public function getDetailViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex){
        require_once('modules/htMultiFilesUploadLicenseAddon/license/htMultiFilesUploadOutfittersLicense.php');
		$validate_license = htMultiFilesUploadOutfittersLicense::isValid('htMultiFilesUploadLicenseAddon');
        if($validate_license === true){
            return parent::getDetailViewSmarty($parentFieldArray, $vardef, $displayParams, $tabindex);
        }else{
            return "<a class='btn btn-danger lis-dito' href='index.php?module=htMultiFilesUploadLicenseAddon&action=license'>Please Configure License.</a>{literal}<script>$('.lis-dito').parent().parent().find('div').first().hide();</script>{/literal}";
        }
    }
}
