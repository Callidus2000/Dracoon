Describe "Create folder"{
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    Context "Test-Room exists"{
        BeforeAll{
            $currentUser=Get-DracoonCurrentAccount -Connection $connection
            $testRoom = New-DracoonDataRoom -Connection $connection -RoomName "FolderTest" -AdminUserId $currentUser.id
            $roomId = $testRoom.id
        }
        AfterAll{
            remove-dracoonNode -connection $connection -NodeId $roomId
        }
        It "Create a folder" {
            $newFolder=New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId
            $newFolder | Should -Not -BeNullOrEmpty
            $queryFolder = Get-DracoonNode -Connection $connection -Filter 'name:eq:MyFolder' -ParentID $roomId
            Write-PSFMessage "queryFolder=$($queryFolder|ConvertTo-Json)"
            $queryFolder.id |Should -Be $newFolder.id
            $queryFolder.parentId | Should -Be $roomId
        }
        It "Create a folder a second time" {
            $newFolder = New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId
            $newFolder | Should -BeNullOrEmpty
            {New-DracoonFolder -Connection $connection -Name "MyFolder" -ParentNodeId $roomId -EnableException $true} |Should -Throw
        }
    }
}