﻿function Connect-Dracoon {
	<#
	.SYNOPSIS
	Creates a new Connection Object to a Dracoon Server instance.

	.DESCRIPTION
	Creates a new Connection Object to a Dracoon Server instance.

	For connecting you always need the -Url as the function needs to know where the Server is located. As a
	minimum additional information you have to provide an authorization, either as -Credential or as -AccessToken.
	The usage of a credential object as the only information is *deprecated* and should be replaces in favor of
	an OAuth workflow. For OAuth you need to configure an application within the Web-UI. For more information
	see about_Dracoon.

DYNAMIC PARAMETERS
-ClientSecret <secret>
    Neccessary for OAuth Login: The Secret of the OAauth Client. Can be ommited if clientID -eq 'dracoon_legacy_scriptingToken'
	and legacy scripting access is activated within the Dracoon instance.

	.PARAMETER Credential
	Credential-Object for direct login.

	.PARAMETER Url
	The server root URL.

	.PARAMETER RefreshToken
	Neccessary for OAuth Login: Refresh-Token. Can be created with Request-OAuthRefreshToken.

	.PARAMETER AccessToken
	Neccessary for OAuth Login: Access-Token. Can be created with Request-OAuthRefreshToken.

	.PARAMETER AuthToken
	Neccessary for OAuth Login: Auth-Token. Can be created with Request-OAuthRefreshToken.

	.PARAMETER ClientID
	Neccessary for OAuth Login: The Id of the OAauth Client.

	.PARAMETER EnableException
	Should Exceptions been thrown?

	.EXAMPLE
	$connection=Connect-Dracoon -Url $url -ClientID $clientId -ClientSecret $clientSecret -Credential $cred

	Connect directly with OAuth and a Credential-Object

	.EXAMPLE
	## Generate accesstoken
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -Credential $cred -TokenType access
	## Login with created access token
	$connection=Connect-Dracoon -Url $url -AccessToken $accessToken

	Connect Via pre-generated OAuth access token

	.EXAMPLE
	## Create a refresh token
	$refreshToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Credential $cred -url $url -TokenType refresh
	## Connect directly with the refresh token
	$connection=Connect-Dracoon -ClientID $clientId -ClientSecret $clientSecret -url $url -RefreshToken $refreshToken

	Connect Via pre-generated OAuth refresh token

	.EXAMPLE
	$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -RefreshToken $refreshToken
	$connection=Connect-Dracoon -Url $url -AccessToken $accessToken

	Second option: Create an access token from the refreh token and login with the access token.

	.EXAMPLE
	## If you are running an older version it maybe possible to login directly. But this option is deprecated and [will be removed in every installation in the future](https://blog.dracoon.com/en/goodbye-x-sds-auth-token-hello-oauth-2.0)
	$connection=Connect-Dracoon -Url $url -Credential $cred

	Direct auth with /auth/login (**Deprecated**)

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
		[parameter(mandatory = $true, ParameterSetName = "authorization_code")]
		[parameter(mandatory = $true, ParameterSetName = "password")]
		[parameter(mandatory = $true, ParameterSetName = "refresh_token")]
		[parameter(mandatory = $true, ParameterSetName = "deprecatedLogin")]
		[parameter(mandatory = $true, ParameterSetName = "AccessToken")]
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingToken")]
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingCredential")]
		[PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.url")]
		[string]$Url,
		[parameter(mandatory = $true, ParameterSetName = "authorization_code")]
		[parameter(mandatory = $true, ParameterSetName = "password")]
		[parameter(mandatory = $true, ParameterSetName = "refresh_token")]
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingToken")]
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingCredential")]
		[string]$ClientID,
		[parameter(mandatory = $true, ParameterSetName = "password")]
		[parameter(mandatory = $true, ParameterSetName = "deprecatedLogin")]
		# [parameter(mandatory = $false, ParameterSetName = "dracoon_legacy_scriptingToken")]
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingCredential")]
		[pscredential]$Credential,
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingToken")]
		# [parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingCredential")]
		[string]$AuthToken,
		[parameter(mandatory = $true, ParameterSetName = "dracoon_legacy_scriptingToken")]
		[parameter(mandatory = $true, ParameterSetName = "refresh_token")]
		[string]$RefreshToken,
		[parameter(mandatory = $true, ParameterSetName = "AccessToken")]
		[string]$AccessToken,
		[switch]$EnableException
	)
	DynamicParam {
		# Neccessary for OAuth Login: The Secret of the OAauth Client.
		Write-PSFMessage -Level Debug "Client-Secret-Check, `$PSCmdlet.ParameterSetName=$($PSCmdlet.ParameterSetName)"
		If ($ClientID -ne "dracoon_legacy_scriptingToken") {
			$associatedParameterSets = @(
				"authorization_code"
				"refresh_token"
				"password"
			)
			Write-PSFMessage -Level Debug "Client-Secret wird benötigt"

			$paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary

			# Defining parameter attributes
			$attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
			foreach ($ParameterSet in $associatedParameterSets) {
				$attributes = New-Object System.Management.Automation.ParameterAttribute
				$attributes.HelpMessage = 'Neccessary for OAuth Login: The Secret of the OAauth Client.'
				$attributes.ParameterSetName = $ParameterSet
				$attributes.Mandatory = $true
				$attributeCollection.Add($attributes)
			}


			# Defining the runtime parameter
			$dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter('ClientSecret', [String], $attributeCollection)
			$paramDictionary.Add('ClientSecret', $dynParam1)

			return $paramDictionary
		}
		else {
			Write-PSFMessage -Level Debug "Client-Secret wird nicht benötigt"
		}
	} #end DynamicParam

	begin {
		$successFullConnected = $false
		$connection = Get-ARAHConnection -Url $Url -APISubPath "/api"
		$connection.ContentType = "application/json;charset=UTF-8"

		Write-PSFMessage "Stelle Verbindung her zu $Url" -Target $Url
		if ($PSCmdlet.ParameterSetName -eq 'deprecatedLogin') {
			# $connection = ::new($Credential, $Url)
			Invoke-PSFProtectedCommand -ActionString "Connect-Dracoon.Connecting" -ActionStringValues $Url -Target $Url -ScriptBlock {
				$apiCallParameter = @{
					Connection = $Connection
					method     = "Post"
					Path       = "/v4/auth/login"
					Body       = @{
						login    = $Credential.UserName
						password = $Credential.GetNetworkCredential().Password
						language = "1"
						authType = "sql"
					}
				}
				$result = Invoke-DracoonAPI @apiCallParameter
				$connection.authenticatedUser = $Credential.UserName
				if ($result.token) { $successFullConnected = $true }
				$connection.headers.Add("X-Sds-Auth-Token", $result.token)

			} -PSCmdlet $PSCmdlet  -EnableException $EnableException
		}
		else {
			if ($PSCmdlet.ParameterSetName -ne 'AccessToken') {
				Write-PSFMessage "Aquiring AccessToken with splatting, ParameterSetName=$($PSCmdlet.ParameterSetName)"
				$AccessToken = Request-DracoonOAuthToken @PSBoundParameters
			}
			if ($AccessToken) {
				$successFullConnected = $true
				$connection.authenticatedUser = "OAuth"
				$connection.headers.Add("Authorization", "Bearer $AccessToken")
			}
		}
	}
	process {
		if (Test-PSFFunctionInterrupt) { return }
		if ($successFullConnected) {
			Write-PSFMessage -string "Connect-Dracoon.Connected"
			return $connection
		}
		Write-PSFMessage -string "Connect-Dracoon.NotConnected" -Level Warning
	}
}