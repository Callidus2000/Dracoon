function Remove-DracoonARShareUpload {
<#
.SYNOPSIS
    Remove Upload Shares

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.21.0</h3>

### Functional Description:
Delete multiple Upload Shares (aka Upload Accounts).

### Precondition:
User has _"manage upload share"_ permissions on target containers.

### Postcondition:
Upload Shares are deleted.

### Further Information:
Only the Upload Shares are removed; already uploaded files and the target container persist.

.PARAMETER Share_id
    Share ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARShareUpload -Share_id $share_id

    ### Description:
Delete an Upload Share (aka File Request).

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage upload share</span> permissions on target container.

### Postcondition:
Upload Share is deleted.

### Further Information:
Only the Upload Share is removed; already uploaded files and the target container persist.

.EXAMPLE
    PS C:\> Remove-DracoonARShareUpload -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.21.0</h3>

### Functional Description:
Delete multiple Upload Shares (aka Upload Accounts).

### Precondition:
User has _"manage upload share"_ permissions on target containers.

### Postcondition:
Upload Shares are deleted.

### Further Information:
Only the Upload Shares are removed; already uploaded files and the target container persist.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeUploadShare')]
        [string]
        $Share_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeUploadShare')]
        [string]
        $XSdsAuthToken,

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
        $__path = 'shares/uploads'
        if ($Share_id) { $__path += "/$Share_id" }
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}