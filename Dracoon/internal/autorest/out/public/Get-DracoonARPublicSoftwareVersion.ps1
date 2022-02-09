function Get-DracoonARPublicSoftwareVersion {
<#
.SYNOPSIS
    Request software version information

.DESCRIPTION
    ### Description:  
Public software version information.

### Precondition:
None.

### Postcondition:
Sofware version information is returned.

### Further Information:
The version of DRACOON Server consists of two components:
* **API**
* **Core** (referred to as _"Server"_)

which are versioned individually.

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Get-DracoonARPublicSoftwareVersion -Connection $connection

    ### Description:  
Public software version information.

### Precondition:
None.

### Postcondition:
Sofware version information is returned.

### Further Information:
The version of DRACOON Server consists of two components:
* **API**
* **Core** (referred to as _"Server"_)

which are versioned individually.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat') -Mapping $__mapping
        $__path = 'public/software/version'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}