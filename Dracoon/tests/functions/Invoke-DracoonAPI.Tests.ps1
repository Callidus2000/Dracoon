Describe "Invoke-DracoonAPI tests with bad data" {
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
        $VerbosePreference="Continue"
    }
    Context "Connection valid" {
        Context "Query negative User-ID" {
            BeforeAll{
                $apiCallParameter = @{
                    Connection   = $Connection
                    method       = "Get"
                    Path         = "/v4/users/-1"
                }
            }
            It "EnableException $false" -TestCases @{enableException=$false} {
                {Invoke-DracoonAPI @apiCallParameter -EnableException $enableException}|Should -Not -Throw
                Invoke-DracoonAPI @apiCallParameter -EnableException $enableException|Should -BeNullOrEmpty
            }
            It "EnableException $false" -TestCases @{enableException=$true} {
                {Invoke-DracoonAPI @apiCallParameter -EnableException $enableException}|Should -Throw
            }
        }
    }
    Context "Connection invalid" {
        BeforeAll{
            $connection.headers.Authorization = "Bearer Xexxxxxxxxxxxxxxxxxxxxxxxxxxx6Nt"
        }
        Context "Query negative User-ID" {
            BeforeAll{
                $apiCallParameter = @{
                    Connection   = $Connection
                    method       = "Get"
                    Path         = "/v4/users/-1"
                }
            }
            It "EnableException $false" -TestCases @{enableException=$false} {
                {Invoke-DracoonAPI @apiCallParameter -EnableException $enableException}|Should -Not -Throw
                Invoke-DracoonAPI @apiCallParameter -EnableException $enableException|Should -BeNullOrEmpty
            }
            It "EnableException $false" -TestCases @{enableException=$true} {
                {Invoke-DracoonAPI @apiCallParameter -EnableException $enableException}|Should -Throw
            }
        }
    }
}