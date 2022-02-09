function New-DracoonARNodeRoomPending {
<#
.SYNOPSIS
    Handle user-room assignments per group

.DESCRIPTION
    ### Description:  
Handles a list of user-room assignments by groups that have **NOT** been approved yet  
**WAITING** or **DENIED** assignments can be **ACCEPTED**.

### Precondition:
None.

### Postcondition:
User-room assignment is approved and the user gets access to the group.

### Further Information:
Room administrators should **SHOULD** handle pending assignments to provide access to rooms for other users.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> New-DracoonARNodeRoomPending -Connection $connection

    ### Description:  
Handles a list of user-room assignments by groups that have **NOT** been approved yet  
**WAITING** or **DENIED** assignments can be **ACCEPTED**.

### Precondition:
None.

### Postcondition:
User-room assignment is approved and the user gets access to the group.

### Further Information:
Room administrators should **SHOULD** handle pending assignments to provide access to rooms for other users.

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
        $__path = 'nodes/rooms/pending'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}