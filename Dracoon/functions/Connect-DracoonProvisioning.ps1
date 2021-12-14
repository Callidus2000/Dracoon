function Connect-DracoonProvisioning {
	<#
	.SYNOPSIS
	Adds the provisioning token to an existing Connection

	.DESCRIPTION
	Adds the provisioning token to an existing Connection

	.PARAMETER Connection
	The existing Dracoon Connection

	.PARAMETER Token
	The provisioning token

	.EXAMPLE
	$connection=Connect-Dracoon -Url $url -ClientID $clientId -ClientSecret $clientSecret -Credential $cred
	Connect-DracoonProvisioning -Connection $connection -Token "1234567"

	Adds the corresponding header for interacting with the provisioning API
	#>

	Param (
		[parameter(mandatory = $true)]
		$Connection,
		[parameter(mandatory = $true)]
		[string]$Token
	)

	begin {
		Write-PSFMessage "Adding token to Header X-Sds-Service-Token"
		$connection.headers.Add("X-Sds-Service-Token", $Token)
	}
}