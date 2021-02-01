Describe "File Upload"{
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    Context "Test-Dataroom exists"{
        BeforeAll{
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            # $uploadRoom = New-DracoonDataRoom -Connection $connection -RoomName "UploadTest" -AdminUserId $currentUser.id
            # $roomId = $uploadRoom.id
            $roomId = 2665
        }
        AfterAll{
            # $uploadRoom|remove-dracoonNode -connection $connection
        }
        It "Upload File" {
            $fileName="$PSScriptRoot\readme.md"
            $fileName|Should -Exist
            Write-PSFMessage "###$PSScriptRoot"
            Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
        }
    }
}