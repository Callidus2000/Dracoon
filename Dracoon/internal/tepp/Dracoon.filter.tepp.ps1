Register-PSFTeppScriptblock -Name "Dracoon.filter" -ScriptBlock {
    switch ($commandName) {
        'Get-DracoonAuditDataroom' {
            'nodeId:eq:[positive Integer]',
            'nodeName:[cn, eq]:[search String]',
            'nodeParentId:eq:[positive Integer]',
            'Parent ID 0 is the root node.:[]:[]',
            'userId:eq:[positive Integer]',
            'userName:[cn, eq]:[search String]',
            'userFirstName:[cn, eq]:[search String]',
            'userLastName:[cn, eq]:[search String]',
            'permissionsManage:eq:[true or false]',
            'nodeIsEncrypted:eq:[true or false]',
            'nodeHasActivitiesLog:eq:[true or false]'
        }
        'Get-DracoonNode' {
            'type:eq:[room[:folder:file]]',
            'perm:eq:[manage[:read:change:create:delete:manageDownloadShare:manageUploadShare:canReadRecycleBin:canRestoreRecycleBin:canDeleteRecycleBin]]',
            'childPerm:eq:[cf. perm]',
            'name:[cn, eq]:[Node name contains / equals value.]',
            'encrypted:eq:[true or false]',
            'branchVersion:[ge, le]:[Branch version is greater / less equals than value.]'
        }
        'Get-DracoonUser'{
            'login:cn:[search String]',
            'firstName:cn:[search String]',
            'lastName:cn:[search String]',
            'isLocked:eq:[true or false]',
            'effectiveRoles:eq:[true or false]'
        }
        'Get-DracoonGroup' {
            'name:cn:[search String]'
        }
        'Get-DracoonUserAttribute' {
            'key:[cn, eq, sw]:[Attribute key contains / equals / starts with value.	]',
            'value:[cn, eq, sw]:[Attribute value contains / equals / starts with value.	]'
        }
        'Get-DracoonRoomAcl' {
            'user:cn:[search String]',
            'userId:eq:[positive Integer]',
            'isGranted:eq:[true/false/any]',
            'permissionsManage:eq:[true or false]',
            'effectivePerm:eq:[true or false]'
        }
        'Search-DracoonNode' {
            'type:[eq]:[room/folder/file]',
            'fileType:[cn, eq]:[search String]',
            'classification:[eq]:[1 - public, 2 - internal, 3 - confidential, 4 - strictly confidential]',
            'createdBy:[cn, eq]:[search String]',
            'createdAt:[ge, le]:[Date (yyyy-MM-dd)]',
            'updatedBy:[cn, eq]:[search String]',
            'updatedAt:[ge, le]:[Date (yyyy-MM-dd)]',
            'expireAt:[ge, le]:[Date (yyyy-MM-dd)]',
            'size:[ge, le]:[size in bytes]',
            'isFavorite:[eq]:[true or false]',
            'branchVersion:[ge, le]:[version number]',
            'parentPath:[cn, eq]:[search String]'
        }
        Default {}
    }
    # $staticList=@(
    #     'https://murks.mydomain.com',
    #     'https://dataexchange.tkds.mydomain.com',
    #     'https://dataexchange.tkdo.mydomain.com',
    #     'https://dataexchange.tkbe.mydomain.com',
    #     'https://dataexchange.tkbr.mydomain.com',
    #     'https://dataexchange.tkme.mydomain.com',
    #     'https://dxi.mydomain.com'
    # )
    # if (-not $env:USERDNSDOMAIN) {
    #     return $staticList
    # }
    # try {
    #     (get-adforest -ErrorAction Stop).domains | ForEach-Object { "https://dataexchange.$($_)" }
    #     'https://dxi.mydomain.com'
    # }
    # catch {
        # return $staticList
    # }
}
