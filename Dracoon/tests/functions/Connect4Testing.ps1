Write-PSFMessage "Connect4Testing" -Level Host
$clientId = Get-PSFConfigValue "Dracoon.pester.clientId" -ErrorAction Stop
$clientSecret = Get-PSFConfigValue "Dracoon.pester.clientSecret" -ErrorAction Stop
$credentials = Get-PSFConfigValue "Dracoon.pester.credentials" -ErrorAction Stop
$fqdn = Get-PSFConfigValue "Dracoon.pester.fqdn" -ErrorAction Stop
$accessToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials -TokenType "access"
$connection = Connect-Dracoon -Url "$fqdn" -AccessToken $accessToken
