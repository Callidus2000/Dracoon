#     [PSCustomObject]GetRoomAcl([int]$roomId) {
#         $result = $this.InvokeGet("/v4/nodes/rooms/$roomId/users")
#         return $result
#     }
function Get-DracoonRoomAcl {
    <#
    .SYNOPSIS
    Retrieve a list of users that are and / or can be granted to the room. API-GET /v4/nodes/rooms/$NodeId/users

    .DESCRIPTION
    Retrieve a list of users that are and / or can be granted to the room.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER NodeId
    ID of the room

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE
    Example:

    permissionsManage:eq:true|user:cn:searchString
    Get all users that have manage permissions to this room AND whose (firstname OR lastname OR email) is like searchString.

    Possible combinations:
    'user:cn:[search String]',
    'userId:eq:[positive Integer]'
    'isGranted:eq:[true/false/any]'
    'permissionsManage:eq:[true/false]'
    'effectivePerm:eq:[true/false]'

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

    .PARAMETER EnablePaging
    Wenn die API mit Paging arbeitet, kann über diesn Parameter ein automatisches Handling aktivieren.
    Dann werden alle Pages abgehandelt und nur die items zurückgeliefert.

    .EXAMPLE
    To be added
    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        [Dracoon]$Connection,
        [parameter(Mandatory)]
        [int]$NodeId,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit = 500,
        [int]$Offset = 0,
        [bool]$EnablePaging = $true
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         = "/v4/nodes/rooms/$NodeId/users"
        EnablePaging = $EnablePaging
        UrlParameter = @{
            filter = $Filter
            limit  = $Limit
            offset = $offset
        }
    }

    Invoke-DracoonAPI @apiCallParameter
}