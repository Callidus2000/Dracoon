function Request-DracoonOAuthToken {
    <#
    .SYNOPSIS
    Helper-Function for creation of an OAuth Token.

    .DESCRIPTION
    The function uses OAuth for creating an refresh token which can be used for login to a dracoon instance.

    .PARAMETER Url
    Base-URL of the Dracoon Server

    .PARAMETER Credential
    Credential object used for login.

    .PARAMETER RefreshToken
    As an alternative a refresh token can be used instead of a credential Object

    .PARAMETER ClientID
    OAuth client ID

    .PARAMETER ClientSecret
    OAuth client secret

    .PARAMETER TokenType
    Defines the type of token to be returned.

    .EXAMPLE
    $authToken=Request-OAuthRefreshToken -Url $serverURL -Credential $credential -ClientID "0O6WWKpp0n***********xk8" -clientSecret "aySR8XB*********99Jj7DFgei"
    $connection = Connect-Dracoon -Url $serverURL -RefreshToken $authToken  -ClientID "0O6WWKpp0n***********xk8" -clientSecret "aySR8XB*********99Jj7DFgei"

    .NOTES
    General notes
    #>
    param (
        [parameter(mandatory = $true, ParameterSetName = "Refresh")]
        [parameter(mandatory = $true, ParameterSetName = "Access")]
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.url")]
        [string]$Url,
        [parameter(mandatory = $true, ParameterSetName = "Refresh")]
        [pscredential]$Credential,
        [parameter(mandatory = $true, ParameterSetName = "Access")]
        [string]$RefreshToken,
        [parameter(mandatory = $true, ParameterSetName = "Refresh")]
        [parameter(mandatory = $true, ParameterSetName = "Access")]
        [string]$ClientID,
        [parameter(mandatory = $true, ParameterSetName = "Refresh")]
        [parameter(mandatory = $true, ParameterSetName = "Access")]
        [string]$ClientSecret,
        [ValidateSet('refresh', 'access')]
        [System.String]$TokenType = 'access'
    )

    $serverRoot = Get-DracoonServerRoot $Url
    $Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $ClientID, $ClientSecret)))
    if ($Credential) {
        # Set Username and Password for first login, escape special characters since we use them in URI parameters
        Write-PSFMessage "OAuth-Anmeldung für User $($Credential.UserName) beim Server $serverRoot"
        $parameter = @{ "grant_type" = "password"; "username" = $Credential.UserName; "password" = $Credential.GetNetworkCredential().password }
    }
    elseif ($RefreshToken) {
        Write-PSFMessage "Create AccessToken from RefreshToken"
        write-psfmessage -Level Debug -Message "Login per refreshToken $RefreshToken, Client-ID/Secret: $($ClientId), $($ClientSecret)"
        $parameter = @{ "grant_type" = "refresh_token"; "refresh_token" = "$RefreshToken" }
    }
    $tokenResponse = Invoke-WebRequest  -URI "$serverRoot/oauth/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $parameter -Headers @{Authorization = ("Basic {0}" -f $Base64AuthInfo) }
    Write-PSFMessage $tokenResponse
    if (($TokenType -eq 'access') -or $RefreshToken) {
        $token = (ConvertFrom-Json $tokenResponse.Content).access_token
    }
    else {
        $token = (ConvertFrom-Json $tokenResponse.Content).refresh_token
    }
    return $token
}