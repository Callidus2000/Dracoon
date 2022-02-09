function New-DracoonARNodeRoomConfig {
<#
.SYNOPSIS
    Configure room

.DESCRIPTION
    ### Description:
Configure a room.

### Precondition:
User needs to be a <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Room Administrator</span>.

### Postcondition:
Room's configuration is changed.

### Further Information:
Provided (or default) classification is taken from room when file gets uploaded without any classification.  

To set `adminIds` or `adminGroupIds` the `inheritPermissions` value has to be `false`. Otherwise use:
* `PUT /nodes/rooms/{room_id}/groups`
* `PUT /nodes/rooms/{room_id}/users `  

APIs.

.PARAMETER Room_id
    Room ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARNodeRoomConfig -Room_id $room_id -Connection $connection

    ### Description:
Configure a room.

### Precondition:
User needs to be a <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Room Administrator</span>.

### Postcondition:
Room's configuration is changed.

### Further Information:
Provided (or default) classification is taken from room when file gets uploaded without any classification.  

To set `adminIds` or `adminGroupIds` the `inheritPermissions` value has to be `false`. Otherwise use:
* `PUT /nodes/rooms/{room_id}/groups`
* `PUT /nodes/rooms/{room_id}/users `  

APIs.

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

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'nodes/rooms/{room_id}/config' -Replace '{room_id}',$Room_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}