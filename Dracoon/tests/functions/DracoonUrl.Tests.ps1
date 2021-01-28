Describe  "Tests for URL TEPP" {
    BeforeAll {
        # Backup old settings
        $oldUrls=Get-PSFConfigValue "Dracoon.tepp.urls"
        Set-PSFConfig -Module 'Dracoon' -Name 'pester.urlbackup' -Value $oldUrls -AllowDelete
        Set-PSFConfig -Module 'Dracoon' -Name 'tepp.urls' -Value 'https://dracoon.team' -AllowDelete
    }
    AfterAll {
        # Backup old settings
        $oldUrls = Get-PSFConfigValue "Dracoon.pester.urlbackup"
        Set-PSFConfig -Module 'Dracoon' -Name 'tepp.urls' -Value $oldUrls -AllowDelete -PassThru | Register-PSFConfig
    }
    It "Only default URL https://dracoon.team is included" {
        $urlList = Get-PSFConfigValue "Dracoon.tepp.urls"
        ($urlList | Measure-Object).Count | Should -Be 1
        $urlList | Should -Contain 'https://dracoon.team'
    }
    It "Adding an additional URL works" {
        # Adding three Servers
        $newUrl = for ($i = 1; $i -lt 4; $i++) { "myserver.$i.domain.com" }
        Write-PSFMessage "newUrl=$newUrl"
        $newUrl | ForEach-Object { Add-DracoonUrl $_ }
        $urlList = Get-PSFConfigValue "Dracoon.tepp.urls"
        ($urlList | Measure-Object).Count | Should -Be 4
        $urlList | Should -Contain 'https://dracoon.team'
        $newUrl | ForEach-Object {
            $urlList | Should -Contain "https://$_"
        }
    }
    It "Known URLs will not be added" {
        # Adding four Servers, first three are already known and will not be added
        $newUrl = for ($i = 1; $i -lt 5; $i++) { "myserver.$i.domain.com" }
        Write-PSFMessage "newUrl=$newUrl"
        Add-DracoonUrl $newUrl
        $urlList = Get-PSFConfigValue "Dracoon.tepp.urls"
        ($urlList | Measure-Object).Count | Should -Be 5
        $urlList | Should -Contain 'https://dracoon.team'
        $newUrl | ForEach-Object {
            $urlList | Should -Contain "https://$_"
        }
    }
    It "Setting URLs overwrites existing list" {
        # Adding four Servers, first three are already known and will not be added
        $checkUrlNotContained = for ($i = 1; $i -lt 5; $i++) { "myserver.$i.domain.com" }
        Set-DracoonUrl @("myserver.domain.com","dracoon.team")
        $urlList = Get-PSFConfigValue "Dracoon.tepp.urls"
        ($urlList | Measure-Object).Count | Should -Be 2
        $urlList | Should -Contain 'https://dracoon.team'

        $checkUrlNotContained | ForEach-Object {
            $urlList | Should -Not -Contain "https://$_"
        }
    }
}