function Connect-Dracoon {
	<#
	.SYNOPSIS
	Creates a new Connection Object to a Dracoon Server instance.

	.DESCRIPTION
	Creates a new Connection Object to a Dracoon Server instance.

	.PARAMETER Credential
	Credential-Object for direct login.

	.PARAMETER Url
	The server root URL.

	.PARAMETER RefreshToken
	Neccessary for OAuth Login: Refresh-Token. Can be created with Request-OAuthRefreshToken.

	.PARAMETER AccessToken
	Neccessary for OAuth Login: Access-Token. Can be created with Request-OAuthRefreshToken.

	.PARAMETER ClientID
	Neccessary for OAuth Login: The Id of the OAauth Client.

	.PARAMETER ClientSecret
	Neccessary for OAuth Login: The Secret of the OAauth Client.

	.PARAMETER EnableException
	Should Exceptions been thrown?

	.EXAMPLE
	# Connect Via OAuth access token
	## Generate accesstoken
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -Credential $cred -TokenType access
	## Login with created access token
	$connection=Connect-Dracoon -Url $url -AccessToken $accessToken
	.EXAMPLE
	# Connect Via OAuth refresh token
	## Create a refresh token
	$refreshToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Credential $cred -url $url -TokenType refresh

	## Connect directly with the refresh token
	$connection=Connect-Dracoon -ClientID $clientId -ClientSecret $clientSecret -url $url -RefreshToken $refreshToken

	.EXAMPLE
	## Second option: Create an access token from the refreh token and login with the access token.
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -RefreshToken $refreshToken
	$connection=Connect-Dracoon -Url $url -AccessToken $accessToken
	.EXAMPLE
	# Direct auth with /auth/login (**Deprecated**)
	## If you are running an older version it maybe possible to login directly. But this option is deprecated and [will be removed in every installation in the future](https://blog.dracoon.com/en/goodbye-x-sds-auth-token-hello-oauth-2.0)
	$connection=Connect-Dracoon -Url $url -Credential $cred
	.NOTES
	As you have to authenticate with OAuth2.0 it is neccessary to create a client application within the admin web-page. For this
	* Go to _System Settings_ / _Apps_ in the navigation bar
	* Click on the _Add app_ button
	* Enter an application name (e.g. "Powershell Scripting")
	* enable all checkboxes (authorization code:implicit:password)
	* Copy the _Client ID_ and the _Client Secret_. Both will be referenced as `$ClientID` and `$ClientSecret`.

	Now it's time to open the powershell. Prepare the basic variables:
	$cred=Get-Credential -Message "Dracoon"
	$clientId="YOU JUST CREATED IT ;-)"
	$clientSecret="THIS ALSO"
	$url="dracoon.mydomain.com"
	#>

	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '')]
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '')]
	[CmdletBinding(DefaultParameterSetName = "AccessToken")]
	Param (
		[parameter(mandatory = $true, ParameterSetName = "Credential")]
		[pscredential]$Credential,
		[parameter(mandatory = $true, ParameterSetName = "AccessToken")]
		[parameter(mandatory = $true, ParameterSetName = "RefreshToken")]
		[parameter(mandatory = $true, ParameterSetName = "Credential")]
		[PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.url")]
		[string]$Url,
		[parameter(mandatory = $true, ParameterSetName = "RefreshToken")]
		[string]$RefreshToken,
		[parameter(mandatory = $true, ParameterSetName = "AccessToken")]
		[string]$AccessToken,
		[parameter(mandatory = $true, ParameterSetName = "RefreshToken")]
		[string]$ClientID,
		[parameter(mandatory = $true, ParameterSetName = "RefreshToken")]
		[string]$ClientSecret,
		[switch]$EnableException
	)

	begin {
		Write-PSFMessage "Stelle Verbindung her zu $Url" -Target $Url
		if ($Credential) {
			# $connection = [Dracoon]::new($Credential, $Url)
			Invoke-PSFProtectedCommand -ActionString "Connect-Dracoon.Connecting" -ActionStringValues $Url -Target $Url -ScriptBlock {
				# $connection = [Dracoon]::new($Credential.username, $Credential.GetNetworkCredential().password, $Url)
				$connection = [Dracoon]::new($Credential, $Url)
			} -PSCmdlet $PSCmdlet  -EnableException $EnableException
		}
		elseif ($RefreshToken) {
			# Invoke-PSFProtectedCommand -ActionString "Connect-Dracoon.Connecting" -ActionStringValues $Url -Target $Url -ScriptBlock {
			# } -PSCmdlet $PSCmdlet  -EnableException $EnableException
			$AccessToken=Request-DracoonOAuthToken -Url $Url -ClientID $ClientID -ClientSecret $ClientSecret -RefreshToken $RefreshToken
			$connection = [Dracoon]::new($AccessToken,$Url)
		}else{
			# Connection with an access token
			$connection = [Dracoon]::new($AccessToken,$Url)
		}
	}
	process {
		if (Test-PSFFunctionInterrupt) { return }
		Write-PSFMessage -string "Connect-Dracoon.Connected"
		$connection
	}
}