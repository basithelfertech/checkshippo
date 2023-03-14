<?php
global $db, $sugar_config, $filename;
 if (isset($_POST['action']) && $_POST['action'] == 'upload') {
    $orgFileName = $_FILES['file']['name'];
    $filename    = create_guid();
    $location    = "upload/" . $filename;
    $type        = $_FILES["file"]["type"];
    move_uploaded_file($_FILES["file"]["tmp_name"], $location);
    echo json_encode(array(
        'file_id'   => $filename,
        'file_name' => $orgFileName,
        'file_type' => $type,
        'file_size' => $_FILES["file"]["size"]
    ));
} 
else if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'file_download') {
	$file_id   = $_REQUEST['file_id'];
    $file_name = $_REQUEST['file_name'];
    header("Pragma: public");
    header('Expires: 0');
    header('Content-Description: File Transfer');
    header('Content-Transfer-Encoding: binary');
    header("Cache-Control: maxage=1, post-check=0, pre-check=0");
    header("Content-Type: application/octet-stream");
    header("Content-Disposition: attachment; filename=" . $file_name . "");
    header("Content-Length: " . filesize('upload://' . $file_id));
    ob_clean();
    flush();
    readfile('upload://' . $file_id);
    die();
} 
 else if (isset($_REQUEST['action']) && $_REQUEST['action'] == 'All_file_download') {
    $basedecod = base64_decode($_REQUEST['id']);
    $jsondecode = json_decode($basedecod);
    $array = json_decode(json_encode($jsondecode),true);
    $direcotr_path = "MultiFileFolder".$_REQUEST['record_id'];
    mkdir($direcotr_path);
    foreach( $array as $value){
        $file_id   = $value['file_id'];
        $file_name = $value['file_name'];
        file_put_contents($direcotr_path.'/'.$file_name,file_get_contents('upload://' . $file_id));  
    }
    $zip_name = $_REQUEST['record_id'].'.zip';
    create_zip_file($direcotr_path,$zip_name);
    $zipFilePath = $zip_name;
    $zipBaseName = basename($zipFilePath);
    ob_clean();
    header("Content-Type: application/zip");
    header("Content-Disposition: attachment; filename=$zipBaseName");
    header("Content-Length: " . filesize($zipFilePath));
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header("Expires: 0");
    readfile($zipFilePath);
    unlink($zipFilePath);
    deleteDir($direcotr_path);
} else if (isset($_POST['action']) && $_POST['action'] == 'file_remove') {
    $file_name = $_POST['file_name'];
    $location  = "upload/" . $file_name;
    unlink($location);
    echo json_encode(array(
        'success' => 'Data deleted successfully!'
    ));
}
function deleteDir($dirPath) {
    if (! is_dir($dirPath)) {
        throw new InvalidArgumentException("$dirPath must be a directory");
    }
    if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
        $dirPath .= '/';
    }
    $files = glob($dirPath . '*', GLOB_MARK);
    foreach ($files as $file) {
        if (is_dir($file)) {
            deleteDir($file);
        } else {
            unlink($file);
        }
    }
    rmdir($dirPath);
}
function create_zip_file($path , $zip_name){
    $rootPath = realpath($path);
    $zip = new ZipArchive();
    $zip->open($zip_name, ZipArchive::CREATE | ZipArchive::OVERWRITE);
    $files = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($rootPath),
        RecursiveIteratorIterator::LEAVES_ONLY
    );
    foreach ($files as $name => $file)
    {
        // Skip directories (they would be added automatically)
        if (!$file->isDir())
        {
            // Get real and relative path for current file
            $filePath = $file->getRealPath();
            $relativePath = substr($filePath, strlen($rootPath) + 1);
            // Add current file to archive
            $zip->addFile($filePath, $relativePath);
        }
    }
    $zip->close();
}

