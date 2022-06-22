function Update-DracoonUser {
    <#
    .SYNOPSIS
    Create a new user.

    .DESCRIPTION
    Create a new user. Two option sets are possible: Mail-User (internal authentication) or Active Directory based authentification.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER User
    The userdata

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = "Mailuser", SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(mandatory = $true)]
        $Connection,
        [parameter(mandatory = $true)]
        $User
    )
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Put"
        Path       = "/v4/users/$($User.id)"
        Body       = $User|ConvertTo-PSFHashtable -Include @(
            # 'title', 'isLocked', 'firstName', 'lastName', 'lockStatus', 'userName', 'isEncryptionEnabled', 'email', 'id', 'userRoles', 'login', 'avatarUuid'
            'authData', 'email', 'expiration', 'firstName', 'isLocked', 'lastName', 'phone', 'receiverLanguage', 'userName'
        ) -Exclude @( 'userAttributes')
    }

    write-psfmessage "($apiCallParameter|convertfrom-json -depth 10)"
    Invoke-PSFProtectedCommand -Action "Update User an" -Target $User.login -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "User erfolgreich angelegt"
        return $result
    } -PSCmdlet $PSCmdlet -Confirm:$false -Verbose
    if (Test-PSFFunctionInterrupt) { return }
}