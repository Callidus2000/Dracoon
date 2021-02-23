function Get-DracoonAuditDataroom {


    <#
    .SYNOPSIS
    Searches Datarooms by given filter. API-GET /v4/eventlog/audits/nodes

    .DESCRIPTION
    Retrieve a list of all nodes of type room, and the room assignment users with permissions.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Except for userName, userFirstName and userLastName - these are connected via logical disjunction (OR)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE[:VALUE...]
    userName:cn:searchString_1|userFirstName:cn:searchString_2|nodeId:eq:2

    Possible combinations:
    'nodeId:eq:[positive Integer]'
    'nodeName:[cn/eq]:[search String]'
    'nodeParentId:eq:[positive Integer]'
    'Parent ID 0 is the root node.:[]:[]'
    'userId:eq:[positive Integer]'
    'userName:[cn/eq]:[search String]'
    'userFirstName:[cn/eq]:[search String]'
    'userLastName:[cn/eq]:[search String]'
    'permissionsManage:eq:[true or false]'
    'nodeIsEncrypted:eq:[true or false]'
    'nodeHasActivitiesLog:eq:[true or false]'

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

    .PARAMETER HideSpecialRooms
    Filters any room which has a GUID as roomName oder Parent-Path

    .EXAMPLE
    Get-DracoonAuditDataroom -Connection $connection

    Lists all available Datarooms

    .NOTES
    Right "read audit log" required.

    #>

    param (
        [parameter(Mandatory)]
        $Connection,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit,
        [int]$Offset,
        [string]$Sort,
        [bool]$HideSpecialRooms=$true
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         = "/v4/eventlog/audits/nodes"
        EnablePaging = $true
        UrlParameter = @{
            filter       = $Filter
            limit        = $Limit
            sort         = $Sort
            offset       = $offset
        }
    }
    $datarooms = Invoke-DracoonAPI @apiCallParameter
    if($HideSpecialRooms){
        Write-PSFMessage "Entferne Datenräume, deren Parent einer GUID entsprechen"
        $regex = '[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?'
        return $datarooms | Where-Object {( $_.nodeParentPath -notmatch $regex) -and ( $_.nodeName -notmatch $regex)}
    }else{
        return $datarooms
    }
}
