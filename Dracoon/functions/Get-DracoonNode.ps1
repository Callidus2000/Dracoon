function Get-DracoonNode {
    <#
    .SYNOPSIS
    Provides a hierarchical list of file system nodes (rooms, folders or
    files) of a given parent that are *accessible* by the current user.

    .DESCRIPTION
    Provides a hierarchical list of file system nodes (rooms, folders or
    files) of a given parent that are accessible by the current user.
    GET /v4/nodes

    .PARAMETER connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE[:VALUE...]

    Possible combinations:
    'type:eq:[room/folder/file]'
    'perm:eq:[manage/read/change/create/delete/manageDownloadShare/manageUploadShare/canReadRecycleBin/canRestoreRecycleBin/canDeleteRecycleBin]'
    'childPerm:eq:[cf perm]'
    'name:[cn/eq]:[Node name]'
    'encrypted:eq:[true/false]'
    'branchVersion:[ge/le]:[Branch version]'


    .PARAMETER Limit
    Range limit. Maximum 500.
    For more results please use paging (offset + limit).

    .PARAMETER Offset
    Range offset

    .PARAMETER Sort
    Sort string syntax: FIELD_NAME:ORDER
    ORDER can be asc or desc.
    Multiple sort fields are NOT supported.
    Nodes are sorted by type first, then by sent sort string.
    Example:

    name:desc

    .PARAMETER ParentID
    Parent node ID.
    Only rooms and folders can be parents.
    Parent ID 0 or empty is the root node.

    .PARAMETER RoomManager
    boolean. Show all rooms for management perspective.
    Only possible for Rooms Managers.
    For all other users, it will be ignored.

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        $connection,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit=500,
        [int]$Offset=0,
        [string]$Sort,
        [int]$ParentID=0,
        $RoomManager
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/nodes"
        EnablePaging = $true
        UrlParameter = @{
            filter=$Filter
            limit=$Limit
            sort=$Sort
            offset=$offset
            parent_id=$ParentID
            room_manager=$RoomManager
        }
        # EnablePaging=$true
    }
    $result = Invoke-DracoonAPI @apiCallParameter
    $result
}