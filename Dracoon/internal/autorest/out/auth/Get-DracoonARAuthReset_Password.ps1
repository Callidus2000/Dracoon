function Get-DracoonARAuthReset_Password {
<#
.SYNOPSIS
    Validate information for password reset

.DESCRIPTION
    ### Description:  
Request all information for a password change dialogue e.g. real name of user.

### Precondition:
User received a password reset token.

### Postcondition:
Context information is returned.

### Further Information:
None.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Password reset token

.EXAMPLE
    PS C:\> Get-DracoonARAuthReset_Password -Connection $connection -Token $token

    ### Description:  
Request all information for a password change dialogue e.g. real name of user.

### Precondition:
User received a password reset token.

### Postcondition:
Context information is returned.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'auth/reset_password/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}