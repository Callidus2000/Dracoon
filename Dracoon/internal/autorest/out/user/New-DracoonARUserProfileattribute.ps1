function New-DracoonARUserProfileattribute {
<#
.SYNOPSIS
    Add or edit user profile attributes

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.7.0</h3>

### Description:  
Add or edit custom user profile attributes.

### Precondition:
None.

### Postcondition:
Custom user profile attributes are added or edited.

### Further Information:
Batch function.  
If an entry existed before, it will be overwritten.  
Range submodel is never returned.

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**  
* Maximum key length is **255**  
* Maximum value length is **4096**

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> New-DracoonARUserProfileattribute -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.7.0</h3>

### Description:  
Add or edit custom user profile attributes.

### Precondition:
None.

### Postcondition:
Custom user profile attributes are added or edited.

### Further Information:
Batch function.  
If an entry existed before, it will be overwritten.  
Range submodel is never returned.

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**  
* Maximum key length is **255**  
* Maximum value length is **4096**

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
        $__path = 'user/profileAttributes'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}