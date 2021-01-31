Describe "Interactive OAuth Login (Three Legged)" {
    Context "Client-ID&-Secret given" {
        BeforeAll {
            $clientId = Get-PSFConfigValue "Dracoon.pester.clientId" -ErrorAction Stop
            $clientSecret = Get-PSFConfigValue "Dracoon.pester.clientSecret" -ErrorAction Stop
            $fqdn = Get-PSFConfigValue "Dracoon.pester.fqdn" -ErrorAction Stop
        }
        It "Aquire Authorization Code" {
            Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID
            $tempCred = Get-Credential -Message "Please perform browser login" -UserName "Enter AuthorizationCode as PW"
            $tempCred | Should -Not -BeNullOrEmpty
            $authToken = $tempCred.GetNetworkCredential().Password
            $accessToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -AuthToken $authToken
            $accessToken | Should -Not -BeNullOrEmpty
            $connection = Connect-Dracoon -Url "https://$fqdn" -AccessToken $accessToken
            $connection | Should -Not -BeNullOrEmpty
            Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -AuthToken $authToken | Should -BeNullOrEmpty
            Test-DracoonConnection -connection $connection |Should -BeTrue
        }
    }
}