function Remove-DracoonARNodeFileUpload {
<#
.SYNOPSIS
    Cancel file upload

.DESCRIPTION
    ### Description:
Cancel a (S3) file upload and destroy the upload channel.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
The upload channel is removed and all temporary uploaded data is purged.

### Further Information:
It is recommended to notify the API about cancelled uploads if possible.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARNodeFileUpload -Upload_id $upload_id -Connection $connection

    ### Description:
Cancel a (S3) file upload and destroy the upload channel.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
The upload channel is removed and all temporary uploaded data is purged.

### Further Information:
It is recommended to notify the API about cancelled uploads if possible.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Upload_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/files/uploads/{upload_id}' -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}