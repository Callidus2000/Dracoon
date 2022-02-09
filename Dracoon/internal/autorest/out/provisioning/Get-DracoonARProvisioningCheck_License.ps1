function Get-DracoonARProvisioningCheck_License {
<#
.SYNOPSIS
    Check license

.DESCRIPTION
    ### Description:  
Check license for the current tenant.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  

### Postcondition:
Updated license information is returned.

### Further Information:
Available license statuses:
* `valid` - license is valid
* `exceeding` - license is about to be exceeded soon (due to number of provisioned customers, users, or storage)
* `expiring` - license is about to expire soon
* `expired` - license is expired
* `exceeded` - license is exceeded (due to number of provisioned customers, users, or storage)
* `invalid` - license is invalid (e.g. invalid license signature)


.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Get-DracoonARProvisioningCheck_License -Connection $connection

    ### Description:  
Check license for the current tenant.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  

### Postcondition:
Updated license information is returned.

### Further Information:
Available license statuses:
* `valid` - license is valid
* `exceeding` - license is about to be exceeded soon (due to number of provisioned customers, users, or storage)
* `expiring` - license is about to expire soon
* `expired` - license is expired
* `exceeded` - license is exceeded (due to number of provisioned customers, users, or storage)
* `invalid` - license is invalid (e.g. invalid license signature)


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsServiceToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsServiceToken' = 'X-Sds-Service-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/check_license'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}