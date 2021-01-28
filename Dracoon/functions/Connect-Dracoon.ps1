function Connect-Dracoon {
	<#
	.SYNOPSIS
	Creates a new Connection Object to a Dracoon Server instance.

	.DESCRIPTION
	Creates a new Connection Object to a Dracoon Server instance.

	.PARAMETER Credential
	Credential-Object zur direkten Anmeldung an Dracoon.

	.PARAMETER Url
	Die Base-URL des Servers

	.PARAMETER RefreshToken
	Bei Anmeldung per OAuth: Refresh-Token. Kann per Request-OAuthRefreshToken erzeugt werden.

	.PARAMETER AccessToken
	Bei Anmeldung per OAuth: Access-Token. Kann per Request-OAuthRefreshToken erzeugt werden.

	.PARAMETER ClientID
	Bei Anmeldung per OAuth: Die ID des OAauth Clients

	.PARAMETER ClientSecret
	Bei Anmeldung per OAuth: Das Secret des OAuth Clients

	.PARAMETER EnableException
	Sollen Exceptions geworfen werden?

	.EXAMPLE
	connect-dracoon -Url https://dataexchange.mydomain.com -Credential $cred
	Stellt eine Verbindung zu https://dataexchange.mydomain.com mit den angegebenen Credentials her

	$authToken=Request-OAuthRefreshToken -Url https://dataexchange.mydomain.com -Credential (Get-StoredCredential -Target "dataexchange.mydomain.com") -ClientID "0O6WWKp********i2B6yxk8" -ClientSecret "aySR8X***********ei"
	$connection = Connect-Dracoon -Url https://dataexchange.mydomain.com -RefreshToken $authToken -ClientID "0O6WWKp********i2B6yxk8" -ClientSecret "aySR8X***********ei"
	Meldet sich per OAuth an


	.NOTES
	General notes
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