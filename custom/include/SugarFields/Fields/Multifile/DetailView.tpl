<div class="{{$vardef.name}}_gallery ScrollStyle row" style="display:inline-flex;width: inherit !important">
	{assign var='fileName' value=$fields.{{$vardef.name}}.value|base64_decode}
    {assign var='fileNameDe' value=$fileName|json_decode:1}
    {foreach from=$fileNameDe item=fileData}
        {if isset($fileData.file_id) && isset($fileData.file_name)}
            {assign var="filename" value=$fileData.file_name}
            {assign var="fileext" value="."|explode:$filename}
				<a target="_blank" href="index.php?entryPoint=AjaxFileUpload&action=file_download&file_id={$fileData.file_id}&file_name={$fileData.file_name}">
                {if $fileext[1] == 'jpg' || $fileext[1] == 'jpeg' || $fileext[1] == 'png' || $fileext[1] == 'gif' || $fileext[1] == 'tiff' || $fileext[1] == 'jfif' }
                    <div class="col-md-4" style="padding:50px; display: inline-block; width: min-content; text-align:center; word-wrap: break-word;">
                    <img  src="index.php?entryPoint=AjaxFileUpload&action=file_download&file_id={$fileData.file_id}&file_name={$fileData.file_name}" alt="file" style="width:75px; height:75px">
                    <br>
                    <br>
                    <div ><a  href="index.php?entryPoint=AjaxFileUpload&action=file_download&file_id={$fileData.file_id}&file_name={$fileData.file_name}" title="Download" data-value="{$fileData.file_id}" title="Download" data-value="{$fileData.file_id}" data-name="{$fileData.file_name}"><span> {$fileData.file_name}  </span></a></div>
                    </div>
                {else}
                    <div class="col-md-4" style="padding:50px; display: inline-block; width: min-content; text-align:center; word-wrap: break-word;">
                    <img  src="custom/include/SugarFields/Fields/Multifile/images/file.png" alt="file" style="width:75px; height:75px ">
                    <br>
                    <br>
                    <div><a  href="index.php?entryPoint=AjaxFileUpload&action=file_download&file_id={$fileData.file_id}&file_name={$fileData.file_name}" title="Download" data-value="{$fileData.file_id}" title="Download" data-value="{$fileData.file_id}" data-name="{$fileData.file_name}"><span> {$fileData.file_name}  </span></a></div>
                    </div>
                {/if}
                </a>
        {/if}
    {/foreach}
</div>
{literal}
{{if !empty($displayParams.enableConnectors)}}
	{{sugarvar_connector view='DetailView'}}
{{/if}}
<script>
$( document ).ready(function() {
    $('.{{$vardef.name}}_gallery').parent().find(".inlineEditIcon").remove();
    $('.ScrollStyle').parent().css({"overflow-x":"auto","overflow-y":"hidden"});

});
</script>
{/literal}