Describe "Test ZIP Download"{
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    Context "Test-Room exists with subfolder and three files"{
        BeforeAll{
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $testRoom = New-DracoonDataRoom -Connection $connection -RoomName "FolderTest" -AdminUserId $currentUser.id
            $roomId = $testRoom.id
            $newFolder=New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId
            $fileName = "$PSScriptRoot\readme.md"
            $fileName | Should -Exist
            $uploadResult = Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
            $uploadResult | Should -Not -BeNullOrEmpty
            $uploadResult = Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
            $uploadResult | Should -Not -BeNullOrEmpty
            $uploadResult = Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $newFolder.id
            $uploadResult | Should -Not -BeNullOrEmpty
            $archiveFileName = "$PSScriptRoot\download.zip"
            $archiveFileName|Should -Not -Exist
            $extractDirectory="$PSScriptRoot\extracted"
            $extractDirectory | Should -Not -Exist
        }
        AfterAll{
            remove-dracoonNode -connection $connection -NodeId $roomId
            Remove-Item $archiveFileName -Force
            Remove-Item $extractDirectory -Force -Recurse
        }
        It "Download dataroom content as zip" {
            $nodes2beDownloaded = Get-DracoonNode -connection $connection -ParentID $roomId
            $nodes2beDownloaded|Should -HaveCount 3
            $downloadResult = $nodes2beDownloaded | Get-DracoonNodeAsZip -Connection $connection -FileName $archiveFileName
            $archiveFileName |Should -Exist
        }
        It "Verify downloaded content" {
            $extractDirectory | Should -Not -Exist
            $archiveFileName |Should -Exist
            Expand-Archive -Path $archiveFileName -DestinationPath $extractDirectory
            $extractDirectory | Should -Exist
            (Get-ChildItem -Path $extractDirectory -Recurse).Count | Should -Be 4
            (Get-ChildItem -Path $extractDirectory -Recurse -Directory).Count | Should -Be 1
            (Get-ChildItem -Path $extractDirectory -Recurse -File).Count | Should -Be 3
        }
        # It "Create a folder a second time" {
        #     $newFolder = New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId
        #     $newFolder | Should -BeNullOrEmpty
        #     {New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId -EnableException $true} |Should -Throw
        # }
    }
}