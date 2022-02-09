function Remove-DracoonARUserOauthAuthorization {
<#
.SYNOPSIS
    Remove a OAuth authorization

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.12.0</h3>

### Description:
Delete an authorization.

### Precondition:
Authenticated user and valid client ID, authorization ID

### Postcondition:
Authorization is revoked.

### Further Information:
None.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Client_id
    OAuth client ID

.PARAMETER Authorization_id
    OAuth authorization ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARUserOauthAuthorization -Client_id $client_id -Authorization_id $authorization_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.12.0</h3>

### Description:
Delete an authorization.

### Precondition:
Authenticated user and valid client ID, authorization ID

### Postcondition:
Authorization is revoked.

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
        [string]
        $Client_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Authorization_id,

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
        $__path = 'user/oauth/authorizations/{client_id}/{authorization_id}' -Replace '{client_id}',$Client_id -Replace '{authorization_id}',$Authorization_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}