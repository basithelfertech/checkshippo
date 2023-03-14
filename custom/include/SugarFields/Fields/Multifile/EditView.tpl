{* custom dropzone like functionality field by h *}
<script type="text/javascript" src='{{sugar_getjspath file="custom/include/SugarFields/Fields/Multifile/SugarFieldMultifile.js"}}'></script>
<link rel="stylesheet" href="custom/include/SugarFields/Fields/Multifile/dropzone/dropzone.min.css" />
<script type="text/javascript" src="custom/include/SugarFields/Fields/Multifile/dropzone/dropzone.min.js"></script>

<input type = "hidden" name = "{{$vardef.name}}_file_id[]" id = "{{$vardef.name}}_file_id" value="{$fields.{{$vardef.name}}.value}" />
{{assign var="dropzoneDivId" value=$vardef.name|replace:'_':'' }}
<div class="needsclick dropzone " id="{{$dropzoneDivId}}dropzone">
<div class="dropzone-previews{{$dropzoneDivId}}"></div>
</div>

{literal}
<script>
var rec_id = $('input[name="record"]').val();    
    if(rec_id){
        Dropzone.autoDiscover = false;
        var {{$dropzoneDivId}}dropzoneMap = {}
        var values = [];
        var {{$dropzoneDivId}}dropzone = new Dropzone(
            "#{{$dropzoneDivId}}dropzone",
        {
            method: 'POST',
            url: 'index.php?entryPoint=AjaxFileUpload',
            maxFilesize: 5, // MB
            addRemoveLinks: true,
            dictDefaultMessage: 'Drop/Choose Your Files',
            createImageThumbnails: true,
            previewsContainer: '.dropzone-previews{{$dropzoneDivId}}',
            success: function (file, response) {
                var res = JSON.parse(response);
                console.log(res);
                $('form#EditView').append('<input type="hidden" name="{{$dropzoneDivId}}dropzone[]" value="' + res.file_id + '::' + res.file_name + '::' + res.file_type + '::' + res.file_size + '">')
                {{$dropzoneDivId}}dropzoneMap[file.file_id] = res.file_id + '::' + res.file_name + '::' + res.file_type + '::' + res.file_size;
                let fileN = res.file_name
                ext = fileN.split(".");
                if( ext[1] == 'jpg' || ext[1] == 'jpeg' || ext[1] == 'png' || ext[1] == 'gif' || ext[1] == 'tiff' || ext[1] == 'jfif' ){
                    this.options.thumbnail.call(this, file, 'index.php?entryPoint=AjaxFileUpload&action=file_download&file_id='+res.file_id+'&file_name='+res.file_name);
                }else{
                    this.options.thumbnail.call(this, file, 'custom/include/SugarFields/Fields/Multifile/images/file3.png');
                }
                {
                    $('[data-dz-thumbnail]').css('height', '100');
                    $('[data-dz-thumbnail]').css('width', '100');
                    $('[data-dz-thumbnail]').css('object-fit', 'cover');
                }; 
            },
            removedfile: function (file, response) {
                file.previewElement.remove()
                if(file.id != ''){
                    $.ajax({
                        type: 'POST',
                        url: 'index.php?entryPoint=AjaxFileUpload',
                        data: {action: 'file_remove', file_name: file.id},
                        success: function (data){
                            $('form#EditView').find('input[name="{{$dropzoneDivId}}dropzone[]"][value="' + file.id + '::' + file.name + '::' + file.type + '::' + file.size + '"]').remove();
                            console.log("File has been successfully removed!!");
                        },
                        error: function(e) {
                            console.log(e);
                        }
                    });
                }
            },
            init: function(response) {
                this.on("sending", function(file, xhr, formData) {
                    formData.append("action", "upload");
                });
                var thisDropzone = this;
                var data = [];
                var thisDropzone = this;
                var path = "upload";
                var file_details = $("#{{$vardef.name}}_file_id").val();
                var decoded = atob(file_details);
                var data = JSON.parse(decoded);
                $.each(data, function(key, value){
                    $('form#EditView').append('<input type="hidden" name="{{$dropzoneDivId}}dropzone[]" value="' + value.file_id + '::' + value.file_name  + '::' + value.file_type + '::' + value.file_size + '">');
                    var {{$dropzoneDivId}}dropzonemockFile = {id: value.file_id, name: value.file_name, type: value.file_type, size: value.file_size };
                    let fileN = value.file_name
                    ext = fileN.split(".");
                    thisDropzone.options.addedfile.call(thisDropzone, {{$dropzoneDivId}}dropzonemockFile);
                    if( ext[1] == 'jpg' || ext[1] == 'jpeg' || ext[1] == 'png' || ext[1] == 'gif' || ext[1] == 'tiff' || ext[1] == 'jfif' ){
                        thisDropzone.options.thumbnail.call(thisDropzone, {{$dropzoneDivId}}dropzonemockFile, 'index.php?entryPoint=AjaxFileUpload&action=file_download&file_id='+value.file_id+'&file_name='+value.file_name);
                    }else{
                        thisDropzone.options.thumbnail.call(thisDropzone, {{$dropzoneDivId}}dropzonemockFile, 'custom/include/SugarFields/Fields/Multifile/images/file3.png');
                    }
                    {
                        $('[data-dz-thumbnail]').css('height', '100');
                        $('[data-dz-thumbnail]').css('width', '100');
                        $('[data-dz-thumbnail]').css('object-fit', 'cover');
                    }; 
                    thisDropzone.emit("complete", {{$dropzoneDivId}}dropzonemockFile);
                });
            } 
        });
    }
    else
    {
        Dropzone.autoDiscover = false;
        var {{$dropzoneDivId}}dropzoneMap = {}
        var values = [];
        var {{$dropzoneDivId}}dropzone = new Dropzone(
            "#{{$dropzoneDivId}}dropzone",
        {
            method: 'POST',
            url: 'index.php?entryPoint=AjaxFileUpload',
            maxFilesize: 5, // MB
            addRemoveLinks: true,
            dictDefaultMessage: 'Drop/Choose Your Files',
            createImageThumbnails: true,
            thumbnailWidth: 75,
            thumbnailHeight: 75, 
            success: function (file, response) {
                var res = JSON.parse(response);
                console.log(res);
                $('form#EditView').append('<input type="hidden" name="{{$dropzoneDivId}}dropzone[]" value="' + res.file_id + '::' + res.file_name + '::' + res.file_type + '::' + res.file_size + '">')
                {{$dropzoneDivId}}dropzoneMap[file.file_id] = res.file_id + '::' + res.file_name + '::' + res.file_type + '::' + res.file_size;
                let fileN = res.file_name
                ext = fileN.split(".");
                if( ext[1] == 'jpg' || ext[1] == 'jpeg' || ext[1] == 'png' || ext[1] == 'gif' || ext[1] == 'tiff' || ext[1] == 'jfif' ){
                    this.options.thumbnail.call(this, file, 'index.php?entryPoint=AjaxFileUpload&action=file_download&file_id='+res.file_id+'&file_name='+res.file_name);
                }else{
                    this.options.thumbnail.call(this, file, 'custom/include/SugarFields/Fields/Multifile/images/file3.png');
                }
                {
                    $('[data-dz-thumbnail]').css('height', '100');
                    $('[data-dz-thumbnail]').css('width', '100');
                    $('[data-dz-thumbnail]').css('object-fit', 'cover');
                }; 
            },
            removedfile: function (file) {
                file.previewElement.remove()
                if(file.id != ''){
                    $.ajax({
                        type: 'POST',
                        url: 'index.php?entryPoint=AjaxFileUpload',
                        data: {action: 'file_remove', file_name: file.id},
                        success: function (data){
                            $('form#EditView').find('input[name="{{$dropzoneDivId}}dropzone[]"][value="' + file.id + '::' + file.name + '::' + file.type + '::' + file.size + '"]').remove();
                            console.log("File has been successfully removed!!");
                        },
                        error: function(e) {
                            console.log(e);
                        }
                    });
                }
            },
            init: function(response) {
                this.on("sending", function(file, xhr, formData) {
                    formData.append("action", "upload");
                });
            }
        });
    }
    function downloadFile(el) {
        SUGAR.ajaxUI.showLoadingPanel();
        var file_id   = $(el).data("value");
        var file_name = $(el).data("name");
        var form_data = new FormData();
        form_data.append("file_id", file_id);
        form_data.append("file_name", file_name);
        form_data.append("action", "file_download");
        $.ajax({
            type: "POST",
            url: "index.php?entryPoint=AjaxFileUpload",
            contentType: false,
            cache: false,
            processData: false,
            data: form_data,
            success: function (response) {
                SUGAR.ajaxUI.hideLoadingPanel();
            },
        });
    }
</script>
{/literal}