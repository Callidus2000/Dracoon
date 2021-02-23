function Search-DracoonNode {
    <#
    .SYNOPSIS
    Provides a flat list of file system nodes (rooms, folders or files) of a given parent that are accessible by the current user.
    API-GET /v4/nodes/search

    .DESCRIPTION
    Provides a flat list of file system nodes (rooms, folders or files) of a given parent that are accessible by the current user.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE[:VALUE...]
    Example:

    type:eq:file|createdAt:ge:2015-01-01
    Get nodes where type equals file AND file creation date is >= 2015-01-01.

    Possible combinations:
    'type:[eq]:[room/folder/file]'
    'fileType:[cn/eq]:[search String]'
    'classification:[eq]:[1 - public/2 - internal/3 - confidential/4 - strictly confidential]'
    'createdBy:[cn/eq]:[search String]'
    'createdAt:[ge/le]:[Date (yyyy-MM-dd)]'
    'updatedBy:[cn/eq]:[search String]'
    'updatedAt:[ge/le]:[Date (yyyy-MM-dd)]'
    'expireAt:[ge/le]:[Date (yyyy-MM-dd)]'
    'size:[ge/le]:[size in bytes]'
    'isFavorite:[eq]:[true or false]'
    'branchVersion:[ge/le]:[version number]'
    'parentPath:[cn/eq]:[search String]'
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

    .PARAMETER DepthLevel
    0 - top level nodes only (default)
    -1 - full tree
    n (any positive number) - include n levels starting from the current node

    .PARAMETER SearchString
    String to be searched in the NodeName

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        $Connection,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit=500,
        [int]$Offset=0,
        [string]$Sort,
        [int]$ParentID = 0,
        [int]$DepthLevel = 0,
        [parameter(Mandatory)]
        [string]$SearchString
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/nodes/search"
        EnablePaging = $true
        UrlParameter = @{
            filter=$Filter
            limit=$Limit
            sort=$Sort
            offset=$offset
            depth_level=$DepthLevel
            parent_id=$ParentID
            room_manager=$RoomManager
            search_string = $SearchString
        }
        # EnablePaging=$true
    }
    $result = Invoke-DracoonAPI @apiCallParameter
    $result
}