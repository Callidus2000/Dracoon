function Get-DracoonARPublicSystemInfoLicense {
<#
.SYNOPSIS
    Request license information

.DESCRIPTION
    ### Description:  
Returns license information for this instance.

### Precondition:
None.

### Postcondition:
License information is returned.

### Further Information:
Available license statuses:
* `valid` - license is valid
* `exceeding` - license is about to be exceeded soon (due to number of provisioned customers, users, or storage)
* `expiring` - license is about to expire soon
* `expired` - license is expired
* `exceeded` - license is exceeded (due to number of provisioned customers, users, or storage)
* `invalid` - license is invalid (e.g. invalid license signature)


.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Get-DracoonARPublicSystemInfoLicense -Connection $connection

    ### Description:  
Returns license information for this instance.

### Precondition:
None.

### Postcondition:
License information is returned.

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
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'public/system/info/license'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}