function Remove-DracoonARRoleUser {
<#
.SYNOPSIS
    Revoke granted role from user(s)

.DESCRIPTION
    ### Description:  
Revoke granted user(s) from a role.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; grant permission on desired role</span> required.  
For each role, at least one non-expiring user **MUST** remain who may grant the role.

### Postcondition:
One or more users will be removed from a role.

### Further Information:
None.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Role_id
    Role ID

.EXAMPLE
    PS C:\> Remove-DracoonARRoleUser -Connection $connection -Role_id $role_id

    ### Description:  
Revoke granted user(s) from a role.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; grant permission on desired role</span> required.  
For each role, at least one non-expiring user **MUST** remain who may grant the role.

### Postcondition:
One or more users will be removed from a role.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Role_id
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'roles/{role_id}/users' -Replace '{role_id}',$Role_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}