function Set-DracoonARUserSubscriptionUpload_Share {
<#
.SYNOPSIS
    Subscribe Upload Share for notifications

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.24.0</h3>

### Description:  
Subscribe Upload Share for notifications.

### Precondition:
User with _"manage upload share"_ permissions on target node.

### Postcondition:
Upload Share is subscribed.  
Notifications for this Upload Share will be triggered in the future.

### Further Information:
None.

.PARAMETER Share_id
    Share ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARUserSubscriptionUpload_Share -Share_id $share_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.24.0</h3>

### Description:  
Subscribe Upload Share for notifications.

### Precondition:
User with _"manage upload share"_ permissions on target node.

### Postcondition:
Upload Share is subscribed.  
Notifications for this Upload Share will be triggered in the future.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Share_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
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
        $__path = 'user/subscriptions/upload_shares/{share_id}' -Replace '{share_id}',$Share_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}