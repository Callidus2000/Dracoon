function Get-DracoonARPublicSoftwareThird_Party_Dependencie {
<#
.SYNOPSIS
    Request third-party software dependencies

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.9.0</h3>

### Description:  
Provides information about used third-party software dependencies.

### Precondition:
None.

### Postcondition:
List of the third-party software dependencies used by **DRACOON Core** (referred to as _"Server"_) is returned.

### Further Information:
None.



.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Get-DracoonARPublicSoftwareThird_Party_Dependencie -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.9.0</h3>

### Description:  
Provides information about used third-party software dependencies.

### Precondition:
None.

### Postcondition:
List of the third-party software dependencies used by **DRACOON Core** (referred to as _"Server"_) is returned.

### Further Information:
None.



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
        $__path = 'public/software/third_party_dependencies'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}