function Set-DracoonARUserUserattribute {
<#
.SYNOPSIS
    Set custom user attributes

.DESCRIPTION
    ### Description:  
Set custom user attributes.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
Custom user attributes are set.

### Further Information:
Batch function.  
All existing user attributes will be deleted.  

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER User_id
    User ID

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARUserUserattribute -User_id $user_id -Connection $connection

    ### Description:  
Set custom user attributes.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
Custom user attributes are set.

### Further Information:
Batch function.  
All existing user attributes will be deleted.  

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $User_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'users/{user_id}/userAttributes' -Replace '{user_id}',$User_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}