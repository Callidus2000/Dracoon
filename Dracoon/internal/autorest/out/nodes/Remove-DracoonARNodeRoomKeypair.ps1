function Remove-DracoonARNodeRoomKeypair {
<#
.SYNOPSIS
    Remove rooms's rescue key pair

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.24.0</h3>

### Description:  
Delete room rescue key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is removed (cf. further information below).

### Further Information:
Please set a new room rescue key pair first and re-encrypt file keys with it.  
If no version is set, deleted key pair with lowest preference value.  
Although, `version` **SHOULD** be set.


.PARAMETER Room_id
    Room ID

.PARAMETER Version
    Version (NEW)

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARNodeRoomKeypair -Room_id $room_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.24.0</h3>

### Description:  
Delete room rescue key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is removed (cf. further information below).

### Further Information:
Please set a new room rescue key pair first and re-encrypt file keys with it.  
If no version is set, deleted key pair with lowest preference value.  
Although, `version` **SHOULD** be set.


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
        $Version,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'Version' = 'version'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Version') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/rooms/{room_id}/keypair' -Replace '{room_id}',$Room_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}