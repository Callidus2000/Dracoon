function Set-DracoonARUserProfileattribute {
<#
.SYNOPSIS
    Set user profile attributes

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.12.0</h3>

### Description:  
Set custom user profile attributes.

### Precondition:
None.

### Postcondition:
Custom user profile attributes are set.

### Further Information:
Batch function.  
All existing user profile attributes will be deleted.  

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**  
* Maximum key length is **255**  
* Maximum value length is **4096**

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Set-DracoonARUserProfileattribute -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.12.0</h3>

### Description:  
Set custom user profile attributes.

### Precondition:
None.

### Postcondition:
Custom user profile attributes are set.

### Further Information:
Batch function.  
All existing user profile attributes will be deleted.  

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
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}