function Remove-DracoonARShareDownload {
<#
.SYNOPSIS
    Remove Download Shares

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.21.0</h3>

### Functional Description:
Delete multiple Download Shares.

### Precondition:
User with _"manage download share"_ permissions on target nodes.

### Postcondition:
Download Shares are deleted.

### Further Information:
Only the Download Shares are removed; the referenced files or containers persists.

.PARAMETER Share_id
    Share ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARShareDownload -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.21.0</h3>

### Functional Description:
Delete multiple Download Shares.

### Precondition:
User with _"manage download share"_ permissions on target nodes.

### Postcondition:
Download Shares are deleted.

### Further Information:
Only the Download Shares are removed; the referenced files or containers persists.

.EXAMPLE
    PS C:\> Remove-DracoonARShareDownload -Share_id $share_id

    ### Description:
Delete a Download Share.

### Precondition:
User with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage download share</span> permissions on target node.

### Postcondition:
Download Share is deleted.

### Further Information:
Only the Download Share is removed; the referenced file or container persists.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeDownloadShare')]
        [string]
        $Share_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeDownloadShare')]
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
        $__path = 'shares/downloads'
        if ($Share_id) { $__path += "/$Share_id" }
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}