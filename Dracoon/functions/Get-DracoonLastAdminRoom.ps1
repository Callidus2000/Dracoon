    # [PSCustomObject]GetLastAdminRooms([int]$userId) {
    #     $result = $this.InvokeGet("/v4/users/$userId/last_admin_rooms")
    #     return $result.items
    # }

function Get-DracoonLastAdminRoom {
    <#
    .SYNOPSIS
    Get rooms where the user is last admin. API-GET /v4/users/$id/last_admin_rooms

    .DESCRIPTION
    Retrieve a list of all rooms where the user is last admin (except homeroom and its subordinary rooms).

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL.

    .PARAMETER Id
    ID of the user

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        $Connection,
        [parameter(Mandatory)]
        [int]$Id
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         = "/v4/users/$Id/last_admin_rooms"
    }

    $result=Invoke-DracoonAPI @apiCallParameter
    $result.items
}