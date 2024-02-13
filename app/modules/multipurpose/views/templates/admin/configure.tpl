<form method="POST">
    <div class="panel>
        <div class="panel-heading">
            {l s='Configuration mod='multipurpose}
        </div>
        <div class="panel-body">
            
                label for="print">{l s='What to print?' mod='multipurpose'}</label>
                <input type="text" name="print" id="print" class="from-control" value="{$MULTIPURPOSE_STR}"/> 
        </div>
        <div class="panel-footer">
            <button type="submit" name="savemultipurposesting"class="btn btn-default pull-right">
                <l class="process-icon-save"></i>
                {l s='Save' mod='multipurpose'}
            </button>
        /<div>
    </div>
</from>  