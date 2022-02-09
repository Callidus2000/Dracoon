function Get-DracoonARUserAccountCustomerKeypair {
<#
.SYNOPSIS
    Request customer's key pair

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.24.0</h3>

### Use `GET /settings/keypair` API

### Description:  
Retrieve the customer rescue key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is returned.

### Further Information:
The private key is password-based encrypted with `AES256` / `PBKDF2`.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARUserAccountCustomerKeypair -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.24.0</h3>

### Use `GET /settings/keypair` API

### Description:  
Retrieve the customer rescue key pair.

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
        $__path = 'user/account/customer/keypair'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}