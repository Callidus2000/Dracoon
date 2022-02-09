function Remove-DracoonARUserUserattribute {
<#
.SYNOPSIS
    Remove custom user attribute

.DESCRIPTION
    ### Description:
Delete custom user attribute.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
Custom user attribute is deleted.

### Further Information:
* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Key
    Key

.PARAMETER User_id
    User ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARUserUserattribute -Key $key -User_id $user_id -Connection $connection

    ### Description:
Delete custom user attribute.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
Custom user attribute is deleted.

### Further Information:
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
        $Key,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $User_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'users/{user_id}/userAttributes/{key}' -Replace '{key}',$Key -Replace '{user_id}',$User_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}