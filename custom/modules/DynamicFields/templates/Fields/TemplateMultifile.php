<?php
require_once('modules/DynamicFields/templates/Fields/TemplateText.php');
class TemplateMultifile extends TemplateText{
  var $type = 'multifile';  
    
  function get_field_def(){
    $def = parent::get_field_def();
    $def['studio'] = 'visible';   
    $def['type'] = 'multifile';
    $def['dbType'] = 'text';

    return $def;  
  }
  
  function __construct() {
  }
  
  function set($values){
      parent::set($values);
  }   
}
?>