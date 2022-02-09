function Remove-DracoonARPublicShareUpload {
<#
.SYNOPSIS
    Cancel file upload

.DESCRIPTION
    ### Description:
Abort (chunked) upload via Upload Share.

### Precondition:
Valid Upload ID.

### Postcondition:
Aborts upload and invalidates upload ID / token.

### Further Information:
None.

.PARAMETER Access_key
    Access key

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARPublicShareUpload -Access_key $access_key -Upload_id $upload_id -Connection $connection

    ### Description:
Abort (chunked) upload via Upload Share.

### Precondition:
Valid Upload ID.

### Postcondition:
Aborts upload and invalidates upload ID / token.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Access_key,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Upload_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'public/shares/uploads/{access_key}/{upload_id}' -Replace '{access_key}',$Access_key -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}