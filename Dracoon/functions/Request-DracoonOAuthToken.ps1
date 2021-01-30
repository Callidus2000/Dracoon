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
        [parameter(mandatory = $true, ParameterSetName = "ThreeLeggedOAuth")]
        [parameter(mandatory = $true, ParameterSetName = "authorization_code")]
        [parameter(mandatory = $true, ParameterSetName = "password")]
        [parameter(mandatory = $true, ParameterSetName = "refresh_token")]
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.url")]
        [string]$Url,
        [parameter(mandatory = $true, ParameterSetName = "ThreeLeggedOAuth")]
        [parameter(mandatory = $true, ParameterSetName = "authorization_code")]
        [parameter(mandatory = $true, ParameterSetName = "password")]
        [parameter(mandatory = $true, ParameterSetName = "refresh_token")]
        [string]$ClientID,
        [parameter(mandatory = $true, ParameterSetName = "authorization_code")]
        [parameter(mandatory = $true, ParameterSetName = "password")]
        [parameter(mandatory = $true, ParameterSetName = "refresh_token")]
        [string]$ClientSecret,
        [parameter(mandatory = $true, ParameterSetName = "password")]
        [pscredential]$Credential,
        [parameter(mandatory = $true, ParameterSetName = "authorization_code")]
        [string]$AuthToken,
        [parameter(mandatory = $true, ParameterSetName = "refresh_token")]
        [string]$RefreshToken,
        [ValidateSet('refresh', 'access')]
        [System.String]$TokenType = 'access'
    )
    $serverRoot = Get-DracoonServerRoot $Url
    $callbackUrl = "$serverRoot/oauth/callback"
    Write-PSFMessage "ParameterSet: $($PSCmdlet.ParameterSetName)"
    if ($PSCmdlet.ParameterSetName -eq 'ThreeLeggedOAuth') {
        # Open Browser to request the accesstoken
        $callbackUrl = [System.Web.HttpUtility]::UrlEncode($callbackUrl)
        $openUrl = "$serverRoot/oauth/authorize?response_type=code&client_id=$ClientId&state=xyz&redirect_uri=$callbackUrl"
        Start-Process $openUrl
        Write-PSFMessage -Level Host "Starting Default Browser for Access Token Generation"
    }
    else {
        $Base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $ClientID, $ClientSecret)))
        switch ($PSCmdlet.ParameterSetName) {
            "password" { $parameter = @{ "grant_type" = "password"; "username" = $Credential.UserName; "password" = $Credential.GetNetworkCredential().password } }
            "refresh_token" { $parameter = @{ "grant_type" = "refresh_token"; "refresh_token" = "$RefreshToken" }}
            "authorization_code" {
                $parameter = @{  grant_type = "authorization_code"; code = $AuthToken ; redirect_uri =$callbackUrl}
                # $parameter="foo=bar&grant_type=authorization_code&code=$AuthToken&redirect_uri=$callbackUrl&bar=foo"
                Write-PSFMessage "parameter=$($parameter|convertto-json)"
            }
            Default { Write-PSFMessage -Level Critical "Unknown ParameterSetName $($PSCmdlet.ParameterSetName)"}
        }
        # if ($Credential) {
        #     # Set Username and Password for first login, escape special characters since we use them in URI parameters
        #     Write-PSFMessage "OAuth-Anmeldung für User $($Credential.UserName) beim Server $serverRoot"
        #     $parameter = @{ "grant_type" = $PSCmdlet.ParameterSetName; "username" = $Credential.UserName; "password" = $Credential.GetNetworkCredential().password }
        # }
        # elseif ($RefreshToken) {
        #     Write-PSFMessage "Create AccessToken from RefreshToken"
        #     write-psfmessage -Level Debug -Message "Login per refreshToken $RefreshToken, Client-ID/Secret: $($ClientId), $($ClientSecret)"
        #     $parameter = @{ "grant_type" = $PSCmdlet.ParameterSetName; "refresh_token" = "$RefreshToken" }
        # }
        try {
            $tokenResponse = Invoke-WebRequest -URI "$serverRoot/oauth/token" -Method Post -ContentType "application/x-www-form-urlencoded" -Body $parameter -Headers @{Authorization = ("Basic {0}" -f $Base64AuthInfo) }
            Write-PSFMessage "tokenResponse=$tokenResponse"
            if (($TokenType -eq 'access') -or $RefreshToken) {
                $token = (ConvertFrom-Json $tokenResponse.Content).access_token
            }
            else {
                $token = (ConvertFrom-Json $tokenResponse.Content).refresh_token
            }
            return $token
        }
        catch {
            $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
            $global:ErrResp = $streamReader.ReadToEnd() | ConvertFrom-Json
            $streamReader.Close()
            Write-PSFMessage "$_"
            Write-PSFMessage "Body=$($parameter)"
            Write-PSFMessage "tokenResponse=$($tokenResponse)"
            Write-PSFMessage "ErrResp=$ErrResp"
        }
    }
}