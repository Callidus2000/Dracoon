Describe "File Upload"{
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    Context "Test-Dataroom exists"{
        BeforeAll{
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $uploadRoom = New-DracoonDataRoom -Connection $connection -RoomName "UploadTest" -AdminUserId $currentUser.id
            $roomId = $uploadRoom.id
        }
        AfterAll{
            remove-dracoonNode -connection $connection -NodeId $roomId
        }
        It "Upload File" {
            $fileName="$PSScriptRoot\readme.md"
            $fileName|Should -Exist
            $uploadResult=Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
            $uploadResult|Should -Not -BeNullOrEmpty
            $uploadResult.parentId | Should -Be $roomId
        }
        It "Uploading a non existent file returns null" {
            $fileName="$PSScriptRoot\fgfgdfgdfgdfgdfgdfg"
            $fileName|Should -Exist -Not
            Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId |Should -BeNullOrEmpty
        }
        It "Uploading a non existent file throws an error (-EnabledException)" {
            $fileName="$PSScriptRoot\fgfgdfgdfgdfgdfgdfg"
            $fileName|Should -Exist -Not
            {Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId -EnableException $true} |Should -Throw
        }
    }
}