Describe "Create Download share"{
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    Context "Test-File exists"{
        BeforeAll{
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $uploadRoom = New-DracoonDataRoom -Connection $connection -RoomName "UploadTest" -AdminUserId $currentUser.id
            $roomId = $uploadRoom.id
            $fileName = "$PSScriptRoot\readme.md"
            $uploadResult = Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
            $fileName | Should -Exist
            $uploadResult | Should -Not -BeNullOrEmpty
            $uploadResult.parentId | Should -Be $roomId
            $nodeId = $uploadResult.id
        }
        AfterAll{
            remove-dracoonNode -connection $connection -NodeId $roomId
        }
        It "File exists" {
            $fileName | Should -Exist
            $uploadResult | Should -Not -BeNullOrEmpty
            $uploadResult.parentId | Should -Be $roomId
            $uploadResult.id | Should -Not -BeNullOrEmpty
            $uploadResult.id | Should -BeGreaterThan 0
        }
        It "Create Downlad Share" {
            $newShare=New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -MaxDownloads 2
            $newShare | Should -Not -BeNullOrEmpty
            $newShare.id | Should -BeGreaterThan 0
        }
        It "Create Downlad Share with Text-Recipient without password" {
            { New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -TextMessageRecipients "0171288" -EnableException  $true} | Should -Throw
        }
        It "Create Downlad Share and send an E-Mail" {
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $newShare=New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -MaxDownloads 2
            $newShare | Should -Not -BeNullOrEmpty
            $mailBody="This is the body"

            $result = Send-DracoonDownloadShareMail -Connection $connection -Id $newShare.id -Recipient $currentUser.email -MailBody $mailBody
            $result|Should -BeNullOrEmpty
        }
        It "Create Malformed Downlad Share" {
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $mailBody="This is the body"
            { Send-DracoonDownloadShareMail -Connection $connection -Id 1 -Recipient $currentUser.email -MailBody $mailBody -EnableException $true } | Should -Throw
            $result= Send-DracoonDownloadShareMail -Connection $connection -Id 1 -Recipient $currentUser.email -MailBody $mailBody -EnableException $false
            $result|Should -BeNullOrEmpty
        }
    }
}