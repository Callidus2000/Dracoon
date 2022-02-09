Describe  "Get-DracoonAuditDataroom tests" {
    BeforeAll {
        . "$PSScriptRoot\Connect4Testing.ps1"
    }
    It "Query current User Information, verify neccessary role LOG_AUDITOR" {
        $connection | Should -Not -BeNullOrEmpty
        $currentUser = Get-DracoonCurrentAccount -Connection $connection
        $currentUser.userRoles.items | Select-Object -ExpandProperty name | Should -Contain 'LOG_AUDITOR'
    }
    It "Query all datarooms via API-GET /v4/eventlog/audits/nodes" {
        $connection | Should -Not -BeNullOrEmpty
        $allDataRooms=Get-DracoonAuditDataroom -Connection $connection -HideSpecialRooms $false
        $regularDataRooms=Get-DracoonAuditDataroom -Connection $connection
        $allDataRooms.count |  Should -BeGreaterThan 0 -Because "There should be datarooms"
        $allDataRooms.count |  Should -Be $regularDataRooms.count
    }
    It "Query all Datarooms, find by filter" {
        $connection | Should -Not -BeNullOrEmpty
        $allDataRooms=Get-DracoonAuditDataroom -Connection $connection
        $allDataRooms.count |  Should -BeGreaterThan 0 -Because "There should be datarooms"
        $firstDataRoom=$allDataRooms|Select-Object -First 1
        {Get-DracoonAuditDataroom -Connection $connection -Filter "nodeId:eq:x"}|Should -Throw
        Get-DracoonAuditDataroom -Connection $connection -Filter "nodeId:eq:0"|Should -BeNullOrEmpty -Because "nodeId=0 does not exist as it's the root"
        $room=Get-DracoonAuditDataroom -Connection $connection -Filter "nodeId:eq:$($firstDataRoom.nodeId)"
        $room| Should -Not -BeNullOrEmpty -Because "We queried it before"
        ($room|Measure-Object).Count|Should -Be 1 -Because "Filtered by nodeId, only one room can qualify"
        Get-DracoonAuditDataroom -Connection $connection -Filter "nodeName:eq:$($firstDataRoom.nodeName)" | Should -Not -BeNullOrEmpty -Because "We queried it before"
        Get-DracoonAuditDataroom -Connection $connection -Filter "nodeName:cn:$($firstDataRoom.nodeName)" | Should -Not -BeNullOrEmpty -Because "We queried it before"
    }
    It "Query all Datarooms, verify sorting" {
        $connection | Should -Not -BeNullOrEmpty
        $allDataRoomsAscending = Get-DracoonAuditDataroom -Connection $connection -HideSpecialRooms $false -Sort "nodeId:asc"
        $allDataRoomsDescending = Get-DracoonAuditDataroom -Connection $connection -HideSpecialRooms $false -Sort "nodeId:desc"
        $allDataRoomsAscending.count |  Should -BeGreaterThan 1 -Because "There should be at least 2 datarooms"
        ($allDataRoomsAscending | Select-Object -First 1 -ExpandProperty nodeId) | Should -Be ($allDataRoomsDescending | Select-Object -Last 1 -ExpandProperty nodeId) -Because "Sorting reversed, first will be the last"
    }
    It "Query all Datarooms, verify limitting" {
        $connection | Should -Not -BeNullOrEmpty
        $onlyOneDataroom = Get-DracoonAuditDataroom -Connection $connection -Limit 1 -HideSpecialRooms $false
        $onlyOneDataroom|Should -Not -BeNullOrEmpty
        ($onlyOneDataroom|Measure-Object).count |Should -Be 1
    }
}