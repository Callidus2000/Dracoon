function New-DracoonARAuthReset_Password {
<#
.SYNOPSIS
    Reset password

.DESCRIPTION
    ### Description:  
Resets user's password.

### Precondition:
User received a password reset token.

### Postcondition:
User's password is reset to the provided password.

### Further Information:
Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Password reset token

.EXAMPLE
    PS C:\> New-DracoonARAuthReset_Password -Connection $connection -Token $token

    ### Description:  
Resets user's password.

### Precondition:
User received a password reset token.

### Postcondition:
User's password is reset to the provided password.

### Further Information:
Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

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
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}