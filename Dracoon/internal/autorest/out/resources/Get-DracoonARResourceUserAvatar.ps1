function Get-DracoonARResourceUserAvatar {
<#
.SYNOPSIS
    Request user avatar

.DESCRIPTION
    ### Description:
Get user avatar.

### Precondition:
Valid user ID and avatar UUID

### Postcondition:
Avatar is returned.

### Further Information:
None.

.PARAMETER User_id
    User ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Uuid
    UUID of the avatar

.EXAMPLE
    PS C:\> Get-DracoonARResourceUserAvatar -User_id $user_id -Connection $connection -Uuid $uuid

    ### Description:
Get user avatar.

### Precondition:
Valid user ID and avatar UUID

### Postcondition:
Avatar is returned.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $User_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Uuid
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'resources/users/{user_id}/avatar/{uuid}' -Replace '{user_id}',$User_id -Replace '{uuid}',$Uuid
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}