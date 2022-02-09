function Set-DracoonARAuthReset_Password {
<#
.SYNOPSIS
    Request password reset

.DESCRIPTION
    ### Description:  
Request an email with a password reset token for a certain user to reset password.

### Precondition:
Registered user account.

### Postcondition:
Provided user receives email with password reset token.

### Further Information:
None.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARAuthReset_Password -Connection $connection

    ### Description:  
Request an email with a password reset token for a certain user to reset password.

### Precondition:
Registered user account.

### Postcondition:
Provided user receives email with password reset token.

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
        $__path = 'auth/reset_password'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}