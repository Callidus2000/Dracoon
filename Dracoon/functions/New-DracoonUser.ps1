function New-DracoonUser {
    <#
    .SYNOPSIS
    Create a new user.

    .DESCRIPTION
    Create a new user. Two option sets are possible: Mail-User (internal authentication) or Active Directory based authentification.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Login
    Unique login for the user, UPN/MAIL format expected

    .PARAMETER FirstName
    First name of the user.

    .PARAMETER LastName
    Last name of the user.

    .PARAMETER Title
    Title of the user.

    .PARAMETER Gender
    Gender of the user.

    .PARAMETER Mail
    Mail address of the user.

    .PARAMETER Domain
    Only needed for Domain based Authentication.

    .PARAMETER SamAccountName
    Login Name Only needed for Domain based Authentication.

    .PARAMETER ExpirationDate
    Sets a date when the user will expire

    .PARAMETER NotifyUser
    If set to true the user is notified by mail.

    .PARAMETER NeedsToChangePassword
    If set to true the user has to change the password on first login.

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
        [parameter(mandatory = $true, ParameterSetName = "Mailuser")]
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        $Connection,
        [parameter(mandatory = $true, ParameterSetName = "Mailuser")]
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        [PSFValidateScript( { $_ -as [mailaddress] }, ErrorMessage = "{0} - is not a valid mail address")]
        [string]$Login,
        [parameter(mandatory = $true, ParameterSetName = "Mailuser")]
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        [string]$FirstName,
        [parameter(mandatory = $true, ParameterSetName = "Mailuser")]
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        [string]$LastName,
        [string]$Title = "",
        [ValidateSet('m', 'f', 'n')]
        [string]$Gender = 'n',
        [string]$Mail,
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        [string]$Domain,
        [parameter(mandatory = $true, ParameterSetName = "ADuser")]
        [string]$SamAccountName,
        [parameter(mandatory = $false, ParameterSetName = "Mailuser")]
        [parameter(mandatory = $false, ParameterSetName = "ADuser")]
        [datetime]$ExpirationDate,
        [parameter(mandatory = $false, ParameterSetName = "Mailuser")]
        [bool]$NotifyUser = $false,
        [parameter(mandatory = $false, ParameterSetName = "Mailuser")]
        [bool]$NeedsToChangePassword = $false
    )
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/users"
        Body       = @{
            firstName             = $FirstName
            lastName              = $LastName
            authMethods           = @()
            login                 = $Login
            title                 = $Title
            gender                = $Gender
            expiration            = @{
                enableExpiration = "false"
                expireAt         = "2018-01-01T00:00:00"
            }
            receiverLanguage      = "de-DE"
            email                 = $Mail
            notifyUser            = ("$NotifyUser").ToLower()
            needsToChangePassword = ("$NeedsToChangePassword").ToLower()
            password              = New-DracoonRandomPassword
        }
    }
    if ($ExpirationDate) {
        $apiCallParameter.Body.expiration.enableExpiration = 'true'
        $apiCallParameter.Body.expiration.expireAt = $ExpirationDate.ToString('yyyy-MM-ddT00:00:00')
    }
    if ($Domain) {
        $adId = (Get-DracoonAuthConfigAD -Connection $Connection -Alias $Domain).id
        if (-not ($adId)) {
            throw "Unbekannter AD-Alias $domain"
        }
        Write-PSFMessage "Lege einen AD-User an ($Domain/$adId)"
        $apicallparameter.Body.authMethods += @{
            authId    = "active_directory"
            isEnabled = "true"
            options   = @(
                @{
                    key   = "ad_config_id"
                    value = $adId
                }
                @{
                    key   = "username"
                    value = $samAccountName
                })
        }
    }
    else {
        Write-PSFMessage "Lege einen SQL-User an ($Domain/$adId)"
        $apicallparameter.Body.authMethods += @{
            authId    = "sql"
            isEnabled = "true"
        }
    }
    write-psfmessage "($apiCallParameter|convertfrom-json -depth 10)"
    Invoke-PSFProtectedCommand -Action "Lege User an" -Target $Login -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "User erfolgreich angelegt"
        $result
    } -PSCmdlet $PSCmdlet -Confirm:$false -Verbose
    if (Test-PSFFunctionInterrupt) { return }
}