function Set-DracoonARAuthOpenidLogin {
<#
.SYNOPSIS
    Complete OpenID Connect authentication

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.14.0</h3>

### Description:  
This is the second step of the OpenID Connect authentication.  
The user hands over the authorization code and is logged in.

### Precondition:
Existing user with activated OpenID Connect authentication that is **NOT** locked.

### Postcondition:
User is logged in.

### Further Information:
None.

.PARAMETER Code
    Authorization code

.PARAMETER State
    Authentication state

.PARAMETER Id_token
    Identity token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARAuthOpenidLogin -Code $code -State $state -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.14.0</h3>

### Description:  
This is the second step of the OpenID Connect authentication.  
The user hands over the authorization code and is logged in.

### Precondition:
Existing user with activated OpenID Connect authentication that is **NOT** locked.

### Postcondition:
User is logged in.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Code,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $State,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Id_token,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'Code' = 'code'
            'State' = 'state'
            'Id_token' = 'id_token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Code','State','Id_token') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'auth/openid/login'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}