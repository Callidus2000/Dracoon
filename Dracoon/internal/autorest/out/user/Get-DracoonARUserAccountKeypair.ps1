function Get-DracoonARUserAccountKeypair {
<#
.SYNOPSIS
    Request user's key pair

.DESCRIPTION
    ### Description:  
Retrieve the user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is returned. 

### Further Information:
The private key is password-based encrypted with `AES256` / `PBKDF2`.

.PARAMETER Version
    Version (NEW)

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARUserAccountKeypair -Connection $connection

    ### Description:  
Retrieve the user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is returned. 

### Further Information:
The private key is password-based encrypted with `AES256` / `PBKDF2`.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Version,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Version' = 'version'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Version') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsAuthToken') -Mapping $__mapping
        $__path = 'user/account/keypair'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}