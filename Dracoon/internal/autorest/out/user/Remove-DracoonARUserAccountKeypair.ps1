function Remove-DracoonARUserAccountKeypair {
<#
.SYNOPSIS
    Remove user's key pair

.DESCRIPTION
    ### Description:  
Delete user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is deleted.

### Further Information:
If parameter `version` is not set, this API deletes version A.  
If two keys with the same version are set, this API deletes the older one.

This will also remove all file keys that were encrypted with the user public key.
If the user had exclusive access to some files, those are removed as well since decrypting them became impossible.

.PARAMETER Version
    Version (NEW)

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARUserAccountKeypair -Connection $connection

    ### Description:  
Delete user key pair.

### Precondition:
Authenticated user.

### Postcondition:
Key pair is deleted.

### Further Information:
If parameter `version` is not set, this API deletes version A.  
If two keys with the same version are set, this API deletes the older one.

This will also remove all file keys that were encrypted with the user public key.
If the user had exclusive access to some files, those are removed as well since decrypting them became impossible.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
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
        $__path = 'user/account/keypair'
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}