function New-DracoonARUserSubscriptionNode {
<#
.SYNOPSIS
    Subscribe or Unsubscribe a List of nodes for notifications

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.25.0</h3>

### Description:  
Subscribe/Unsubscribe nodes for notifications.

### Precondition:
User has _"read"_ permissions in auth parent room.

### Postcondition:
Nodes are subscribed or unsubscribed.
Notifications for these nodes will be triggered in the future.

### Further Information:
Maximum number of subscriptions is 200.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> New-DracoonARUserSubscriptionNode -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.25.0</h3>

### Description:  
Subscribe/Unsubscribe nodes for notifications.

### Precondition:
User has _"read"_ permissions in auth parent room.

### Postcondition:
Nodes are subscribed or unsubscribed.
Notifications for these nodes will be triggered in the future.

### Further Information:
Maximum number of subscriptions is 200.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'user/subscriptions/nodes'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}