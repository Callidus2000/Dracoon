function Set-DracoonARUserAccountKeypair {
<#
.SYNOPSIS
    Set user's key pair

.DESCRIPTION
    ### Description:  
Set the user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is set.

### Further Information:
Overwriting an existing key pair is **NOT** possible.  
Please delete the existing key pair first.  
The private key is password-based encrypted with `AES256` / `PBKDF2`.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Set-DracoonARUserAccountKeypair -Connection $connection

    ### Description:  
Set the user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is set.

### Further Information:
Overwriting an existing key pair is **NOT** possible.  
Please delete the existing key pair first.  
The private key is password-based encrypted with `AES256` / `PBKDF2`.

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
        $__path = 'user/account/keypair'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}