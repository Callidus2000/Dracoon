function Request-DracoonOAuthToken {
    <#
    .SYNOPSIS
    Helper-Function for creation of OAuth Tokens.

    .DESCRIPTION
    The function uses OAuth for creating an refresh token which can be used for login to a dracoon instance.
    For connecting to Dracoon via OAuth you always need the -Url as the function needs to know where the Server is located.
    Furthermore you need an AccessToken which can be requested with this function.
    Besides the ClientId/ClientSecret you need to provide one of the following:
    -Credential
    -RefreshToken
    -AuthToken

    The RefreshToken and AuthToken can be generated with this function, too.
    For more information about OAuth see about_Dracoon.

    .PARAMETER Url
    Base-URL of the Dracoon Server

    .PARAMETER Credential
    Credential object used for login.

    .PARAMETER RefreshToken
    As an alternative a refresh token can be used instead of a credential Object

    .PARAMETER AuthToken
    Authorization Token/Code from Three Legged OAuth Workflow

    .PARAMETER ClientID
    OAuth client ID

    .PARAMETER ClientSecret
    OAuth client secret

    .PARAMETER TokenType
    Defines the type of token to be returned, default "access"

    .EXAMPLE
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -Credential $cred -TokenType access
    #Creates an AccessToken which can be used for simple connection-
	$connection=Connect-Dracoon -Url $url -AccessToken $accessToken

    .EXAMPLE
	$refreshToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Credential $cred -url $url -TokenType refresh
	# Creates a refresh token which can be exchanged for an accessToken.
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -RefreshToken $refreshToken

	.EXAMPLE
    Request-DracoonOAuthToken -url $url -ClientID $ClientID
    Opens the default browser for aquiring an authorization code.

    .EXAMPLE
    #Read authorization code and generate an access code from it.
    $tempCred = Get-Credential -Message "Please perform browser login" -UserName "Enter AuthorizationCode as PW"
    $authToken = $tempCred.GetNetworkCredential().Password
    $accessToken = Request-DracoonOAuthToken -url $url -ClientID $ClientID -clientSecret $clientSecret -AuthToken $authToken


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
            "refresh_token" { $parameter = @{ "grant_type" = "refresh_token"; "refresh_token" = "$RefreshToken" } }
            "authorization_code" {
                $parameter = @{  grant_type = "authorization_code"; code = $AuthToken ; redirect_uri = $callbackUrl }
                # $parameter="foo=bar&grant_type=authorization_code&code=$AuthToken&redirect_uri=$callbackUrl&bar=foo"
                # Write-PSFMessage "parameter=$($parameter|convertto-json)"
            }
            Default { Write-PSFMessage -Level Critical "Unknown ParameterSetName $($PSCmdlet.ParameterSetName)" }
        }
        # Write-PSFMessage "parameter=$($parameter|convertto-json)"
        $tokenParameter = @{
            URI         = "$serverRoot/oauth/token"
            Method      = "Post"
            ContentType = "application/x-www-form-urlencoded"
            Body        = $parameter  #($parameter | convertto-json)
            Headers     = @{
                Authorization = ("Basic {0}" -f $Base64AuthInfo)
            }
        }
        # Write-PSFMessage "tokenParameter=$($tokenParameter|convertto-json)"
        try {
            Write-ARAHCallMessage $tokenParameter
            $tokenResponse = Invoke-WebRequest @tokenParameter
            # Write-PSFMessage "tokenResponse=$tokenResponse"
            if (($TokenType -eq 'access') -or $RefreshToken) {
                $token = (ConvertFrom-Json $tokenResponse.Content).access_token
            }
            else {
                $token = (ConvertFrom-Json $tokenResponse.Content).refresh_token
            }
            return $token
        }
        catch {
            Write-PSFMessage "Exception: $_"
            $streamReader = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream())
            $errResp = $streamReader.ReadToEnd() | ConvertFrom-Json
            $streamReader.Close()
            Write-PSFMessage "Error-Response=$ErrResp"
        }
    }
}