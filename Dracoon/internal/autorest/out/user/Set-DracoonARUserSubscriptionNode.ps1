function Set-DracoonARUserSubscriptionNode {
<#
.SYNOPSIS
    Subscribe node for notifications

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.20.0</h3>

### Description:
Subscribe node for notifications.

### Precondition:
User has _"read"_ permissions in auth parent room.

### Postcondition:
Node is subscribed.
Notifications for this node will be triggered in the future.

### Further Information:
None.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Node_id
    Node ID

.EXAMPLE
    PS C:\> Set-DracoonARUserSubscriptionNode -Connection $connection -Node_id $node_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.20.0</h3>

### Description:
Subscribe node for notifications.

### Precondition:
User has _"read"_ permissions in auth parent room.

### Postcondition:
Node is subscribed.
Notifications for this node will be triggered in the future.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Node_id
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'user/subscriptions/nodes/{node_id}' -Replace '{node_id}',$Node_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}