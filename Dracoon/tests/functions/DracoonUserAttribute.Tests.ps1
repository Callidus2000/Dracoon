Describe  "Tests for Get-DracoonUserAttribute and Set-DracoonUserAttribute" {
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
        $pesterMailDomain = "not.existing.com"
        $param = @{
            Connection = $Connection
            Login      = "jane.pester@$pesterMailDomain"
            FirstName  = "Jane"
            LastName   = "Pester"
            Gender     = "n"
        }
        New-DracoonUser @param
        $jane = Get-DracoonUser -Connection $Connection -Filter "login:cn:jane.pester@$pesterMailDomain"
    }
    AfterAll {
        $pesterUser = Get-DracoonUser -Connection $Connection -Filter 'lastName:cn:pester'
        $pesterUser | Remove-DracoonUser -Connection $Connection
    }
    It "User Jane Pester does exist"{
        $jane | Should -Not -BeNullOrEmpty
        $jane.login | Should -Be "jane.pester@$pesterMailDomain"
    }
    It "User Jane Pester has no attributes yet"{
        $attributes = Get-DracoonUserAttribute -connection $Connection -Id $jane.id
        write-psfmessage "$($attributes|convertto-json)"
        $attributes | Should  -BeNullOrEmpty
    }
    It "Setting new Attribute for Wrong user"{
        { Set-DracoonUserAttribute -connection $Connection -Id 0 -UserAttributes @{} } | Should -Throw "*User ID must be positive*"
    }
    It "Setting new Attribute for User Jane Pester"{
        $newAttributes = @{
            Foo="bar"
            CallSign="Wasp"
        }
        {Set-DracoonUserAttribute -connection $Connection -Id $jane.id -UserAttributes $newAttributes} |Should -Not -Throw
    }
    It "User Jane Pester has two attributes"{
        $attributes = Get-DracoonUserAttribute -connection $Connection -Id $jane.id
        write-psfmessage "##$($attributes|convertto-json)"
        $attributes | Should -Not -BeNullOrEmpty
        $attributes.Foo |Should -Be "bar"
        $attributes.CallSign | Should -Be "Wasp"
    }
    It "Adding a third Attribute for User Jane Pester"{
        $newAttributes = @{
            Size="Small"
        }
        {Set-DracoonUserAttribute -connection $Connection -Id $jane.id -UserAttributes $newAttributes} |Should -Not -Throw
    }
    It "User Jane Pester has two attributes"{
        $attributes = Get-DracoonUserAttribute -connection $Connection -Id $jane.id
        write-psfmessage "##$($attributes|convertto-json)"
        $attributes | Should -Not -BeNullOrEmpty
        $attributes.Foo |Should -Be "bar"
        $attributes.CallSign | Should -Be "Wasp"
        $attributes.Size | Should -Be "Small"
    }
    It "Overwrite the three Attributes with only two for User Jane Pester"{
        $newAttributes = @{
            Foo      = "bar"
            CallSign = "Wasp"
        }
        {Set-DracoonUserAttribute -connection $Connection -Id $jane.id -UserAttributes $newAttributes -Overwrite $true} |Should -Not -Throw
    }
    It "User Jane Pester has two attributes"{
        $attributes = Get-DracoonUserAttribute -connection $Connection -Id $jane.id
        write-psfmessage "###$($attributes|convertto-json)"
        $attributes | Should -Not -BeNullOrEmpty
        $attributes.Foo |Should -Be "bar"
        $attributes.CallSign | Should -Be "Wasp"
        $attributes.Size | Should -BeNullOrEmpty
    }
    It "Remove all Attributes  for User Jane Pester"{
        {Set-DracoonUserAttribute -connection $Connection -Id $jane.id -UserAttributes @{} -Overwrite $true} |Should -Not -Throw
    }
    It "User Jane Pester has no attributes" {
        $attributes = Get-DracoonUserAttribute -connection $Connection -Id $jane.id
        $attributes | Should  -BeNullOrEmpty
    }
}