Describe  "Get-DracoonCurrentAccount tests" {
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    It "Query current User Information" {
        $connection | Should -Not -BeNullOrEmpty
        $currentUser = Get-DracoonCurrentAccount -Connection $connection
        $currentUser | Should -Not -BeNullOrEmpty
        $properties = $currentUser | get-member -MemberType NoteProperty | Select-Object -ExpandProperty name
        $expectedProperties = @('email', 'firstName', 'id', 'isLocked', 'lastLoginFailAt', 'lastLoginSuccessAt', 'lastName', 'lockStatus', 'login')
        foreach ($prop in $expectedProperties) {
            $properties | Should -Contain $prop
        }
        $currentUser.login | Should -Not -BeNullOrEmpty
    }
}