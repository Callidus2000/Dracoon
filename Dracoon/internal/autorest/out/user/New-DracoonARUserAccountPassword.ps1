function New-DracoonARUserAccountPassword {
<#
.SYNOPSIS
    Change user's password

.DESCRIPTION
    ### Description:
Change the user's password.

### Precondition:
Authenticated user.

### Postcondition:
User's password is changed.

### Further Information:
The password **MUST** comply to configured password policies.  

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> New-DracoonARUserAccountPassword -Connection $connection

    ### Description:
Change the user's password.

### Precondition:
Authenticated user.

### Postcondition:
User's password is changed.

### Further Information:
The password **MUST** comply to configured password policies.  

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

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
        $__path = 'user/account/password'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}