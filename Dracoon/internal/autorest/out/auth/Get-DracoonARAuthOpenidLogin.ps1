function Get-DracoonARAuthOpenidLogin {
<#
.SYNOPSIS
    Initiate OpenID Connect authentication

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.14.0</h3>

### Description:
This is the first step of the OpenID Connect authentication.  
The user is send to the OpenID Connect identity provider to authenticate himself and retrieve an authorization code.

### Precondition:
None.

### Postcondition:
User is redirected to OpenID Connect identity provider to authenticate himself.

### Further Information:
None.

.PARAMETER Issuer
    Issuer identifier of the OpenID Connect identity provider

.PARAMETER Language
    Language ID or ISO 639-1 code

.PARAMETER Redirect_uri
    Redirect URI to complete the OpenID Connect authentication

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Test
    Flag to test the authentication parameters.

If the request is valid, the API will respond with `204 No Content`.

.EXAMPLE
    PS C:\> Get-DracoonARAuthOpenidLogin -Issuer $issuer -Language $language -Redirect_uri $redirect_uri -Connection $connection -Test $test

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.14.0</h3>

### Description:
This is the first step of the OpenID Connect authentication.  
The user is send to the OpenID Connect identity provider to authenticate himself and retrieve an authorization code.

### Precondition:
None.

### Postcondition:
User is redirected to OpenID Connect identity provider to authenticate himself.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Issuer,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Language,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Redirect_uri,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Test
    )
    process {
        $__mapping = @{
            'Issuer' = 'issuer'
            'Language' = 'language'
            'Redirect_uri' = 'redirect_uri'
            'Connection' = 'Connection'
            'Test' = 'test'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Issuer','Language','Redirect_uri','Test') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'auth/openid/login'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}