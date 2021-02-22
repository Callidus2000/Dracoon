Describe  "Connection tests" {
    Describe "Test internal ServerRoot-Helper" {
        It "Check converting a given URL" {
            Get-DracoonServerRoot "my.server.de" | Should -Be "https://my.server.de"
            Get-DracoonServerRoot "my.server.de/" | Should -Be "https://my.server.de"
            Get-DracoonServerRoot "http://my.server.de" | Should -Be "https://my.server.de"
            Get-DracoonServerRoot "http://my.server.de/" | Should -Be "https://my.server.de"
        }
    }
    Context "OAuth registration available" {
        BeforeAll {
            $clientId = Get-PSFConfigValue "Dracoon.pester.clientId" -ErrorAction Stop
            $clientSecret = Get-PSFConfigValue "Dracoon.pester.clientSecret" -ErrorAction Stop
            $credentials = Get-PSFConfigValue "Dracoon.pester.credentials" -ErrorAction Stop
            $fqdn = Get-PSFConfigValue "Dracoon.pester.fqdn" -ErrorAction Stop
            $VerbosePreference = "Continue"
        }
        It "Anmeldung ohne OAuth, falsche Credentials" {
            $wrongCreds = new-object -typename System.Management.Automation.PSCredential -argumentlist "anonymous", (ConvertTo-SecureString "password" -AsPlainText -Force)
            $connection = Connect-Dracoon -Url "$fqdn" -Credential $wrongCreds
            $connection | Should -BeNullOrEmpty
            { Test-DracoonConnection -Connection $connection } | Should -Throw "Cannot bind argument*"
        }
        It "Anmeldung ohne OAuth" {
            $connection = Connect-Dracoon -Url "https://$fqdn" -Credential $credentials
            $connection | Should -Not -BeNullOrEmpty
            Test-DracoonConnection -Connection $connection | Should -BeTrue
            write-psfmessage "connection=$connection"
        }
        It "Anmeldung mit OAuth, über ein RefreshToken" {
            $connection = Connect-Dracoon -Url "https://$fqdn" -Credential $credentials
            $connection | Should -Not -BeNullOrEmpty
            Test-DracoonConnection -Connection $connection | Should -BeTrue
            write-psfmessage "connection=$connection"
        }
        It "Create an Access Token" {
            $accessToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials -TokenType "access"
            $accessToken | Should -Match "\w{32}"
        }
        Context "Direct login with Connect-Dracoon without explicit usage of Request-DracoonOAuthToken"{
            It "Connect with grant_type=password"{
                $connection=Connect-Dracoon -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials
                $connection | Should -Not -BeNullOrEmpty
                Test-DracoonConnection -Connection $connection | Should -BeTrue
            }
            It "Connect with grant_type=refresh_token"{
                $refreshToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials -TokenType "refresh"
                $connection=Connect-Dracoon -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -RefreshToken $refreshToken
                $connection | Should -Not -BeNullOrEmpty
                Test-DracoonConnection -Connection $connection | Should -BeTrue
            }
        }
        Context "Create an Refresh Token and a Access Token based on it" {
            beforeall {
                $refreshToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials -TokenType "refresh"
                $accessToken = Request-DracoonOAuthToken -url $fqdn -ClientID $ClientID -clientSecret $clientSecret -RefreshToken $refreshToken
            }
            It "Access token gets generated from RefrehToken" {
                $refreshToken | Should -Match "\w{32}" -Because "RefreshToken is alphanumeric and 32 long"
                $accessToken | Should -Match "\w{32}" -Because "AccessToken is alphanumeric and 32 long"
                $accessToken | Should -not -Be $refreshToken -Because "AccessToken is different from RefreshToken"
            }
            It "Login with generated access token" {
                $accessToken | Should -Match "\w{32}" -Because "AccessToken is alphanumeric and 32 long"
                $connection=Connect-Dracoon -Url "https://$fqdn" -AccessToken $accessToken
                $connection | Should -Not -BeNullOrEmpty
                Test-DracoonConnection -Connection $connection | Should -BeTrue
            }
            It "Login with refresh token" {
                $refreshToken | Should -Match "\w{32}" -Because "AccessToken is alphanumeric and 32 long"
                $connection = Connect-Dracoon -Url "https://$fqdn" -RefreshToken $refreshToken -ClientID $ClientID -clientSecret $clientSecret
                $connection | Should -Not -BeNullOrEmpty
                Test-DracoonConnection -Connection $connection | Should -BeTrue
            }
            It "Connection not pingable" {
                $accessToken | Should -Match "\w{32}" -Because "AccessToken is alphanumeric and 32 long"
                $connection=Connect-Dracoon -Url "https://$fqdn" -AccessToken $accessToken
                $connection.webServiceRoot="$($connection.webServiceRoot)/notAvailable"
                Test-DracoonConnection -Connection $connection  | Should -Be $false
            }
        }
    }
}