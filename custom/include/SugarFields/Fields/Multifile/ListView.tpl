{capture name=check assign=checktrue}
    {sugar_fetch object=$parentFieldArray key=$col}
{/capture}
{assign var='fileName' value=$checktrue|base64_decode}
{assign var='fileN' value=$fileName|json_decode}
{assign var='file1' value=$fileN|json_encode}
{assign var='file2' value=$file1|json_decode}
{if empty($file2)}
    No file added
{else}
    <a href="index.php?entryPoint=AjaxFileUpload&action=All_file_download&record_id={$parentFieldArray.ID}&id={sugar_fetch object=$parentFieldArray key=$col}" class="tabDetailViewDFLink" target='_blank'>
        Click here to download files
    </a>
{/if}