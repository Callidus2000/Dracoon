Describe  "Tests for Get-DracoonUser and Remove-DracoonUser" {
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
        $pesterMailDomain = "not.existing.com"
    }
    Context "No Pester-User-Accounts exist" {
        It "Check that querying nonsense does return null" {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter "login:cn:56bf74bf-d694-458b-89c7-495522eca84d"
            ($pesterUser | Measure-Object).Count | Should -Be 0
            $pesterUser  | Should -BeNullOrEmpty
        }
        It "Check that no Pester-User exists" {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter "login:cn:$pesterMailDomain"
            ($pesterUser | Measure-Object).Count | Should -Be 0
        }
        It "Create an internal User" {
            $param = @{
                Connection = $Connection
                Login      = "jane.pester@$pesterMailDomain"
                FirstName  = "Jane"
                LastName   = "Pester"
                Title      = ""
                Gender     = "n"
            }
            New-DracoonUser @param | Should -Not -BeNullOrEmpty
        }
        It "Check that created Pester-User exists" {
            $jane = Get-DracoonUser -Connection $Connection -Filter "login:cn:jane.pester@$pesterMailDomain"
            $jane | Should -Not -BeNullOrEmpty
            $jane.login | Should -Be "jane.pester@$pesterMailDomain"
        }
        AfterAll {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter 'lastName:cn:pester'
            $pesterUser | Remove-DracoonUser -Connection $Connection
        }
    }
    Context "10 Dummy User created" {
        BeforeAll {
            # Create 10 Test-User
            for ($i = 10; $i -lt 20; $i++) {
                $param = @{
                    Connection = $Connection
                    Login      = "joe.pester.$i@not.existing.com"
                    FirstName  = "Joe"
                    LastName   = "Pester $i"
                    Title      = ""
                    Gender     = "n"
                }
                Write-PSFMessage -Level Host "### joe.pester.$i@not.existing.com"
                New-DracoonUser @param
            }
        }
        It "Check that 10 Pester-User exists" {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter "login:cn:$pesterMailDomain"
            ($pesterUser | Measure-Object).Count | Should -Be 10
        }
        It "Check that Automatic Paging does work" {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter "login:cn:$pesterMailDomain" -Limit 3
            ($pesterUser | Measure-Object).Count | Should -Be 10
        }
        It "Check that Automatic Paging can be disabled" {

            $result = Get-DracoonUser -Connection $Connection -Filter "login:cn:$pesterMailDomain" -Limit 3 -EnablePaging $false
            $pesterUser=$result.items
            ($pesterUser | Measure-Object).Count | Should -Be 3
            $result.range.total | Should -Be 10
        }
        AfterAll {
            $pesterUser = Get-DracoonUser -Connection $Connection -Filter 'lastName:cn:pester'
            $pesterUser | Remove-DracoonUser -Connection $Connection
        }
    }
}