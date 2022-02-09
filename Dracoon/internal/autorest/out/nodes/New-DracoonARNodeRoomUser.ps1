function New-DracoonARNodeRoomUser {
<#
.SYNOPSIS
    Add or change room granted user(s)

.DESCRIPTION
    ### Description:
All existing user permissions will be overwritten.

### Precondition:
User needs to be a <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Room Administrator</span>. To add new members, the user needs the right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; non-members add</span>, which is included in any role.

### Postcondition:
User's permissions are changed.

### Further Information:
Batch function.

.PARAMETER Room_id
    Room ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARNodeRoomUser -Room_id $room_id -Connection $connection

    ### Description:
All existing user permissions will be overwritten.

### Precondition:
User needs to be a <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Room Administrator</span>. To add new members, the user needs the right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; non-members add</span>, which is included in any role.

### Postcondition:
User's permissions are changed.

### Further Information:
Batch function.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Room_id,

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
        $__path = 'nodes/rooms/{room_id}/users' -Replace '{room_id}',$Room_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}