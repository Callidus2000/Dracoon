function Set-DracoonRoomAcl {
    <#
    .SYNOPSIS
    Add or change room granted user(s). API-PUT /v4/nodes/rooms/$NodeId/users

    .DESCRIPTION
    Batch function. All existing user permissions will be overwritten.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER NodeId
    ID of the room

    .PARAMETER NewPermission
    Array of the new Permission Items.
    [
        {
            "id": 0,
            "permissions": {
                "manage": true,
                "read": true,
                "create": true,
                "change": true,
                "delete": true,
                "manageDownloadShare": true,
                "manageUploadShare": true,
                "readRecycleBin": true,
                "restoreRecycleBin": true,
                "deleteRecycleBin": true
            }
        }
    ]

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(Mandatory)]
        $Connection,
        [parameter(Mandatory)]
        [int]$NodeId,
        [array]$NewPermission
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Put"
        Path         = "/v4/nodes/rooms/$NodeId/users"
        Body=@{
            items=@()
        }
    }
    $apiCallParameter.Body.items += $NewPermission
    Invoke-PSFProtectedCommand -Action "Setting permissions on node" -Target "$NodeId" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "Permissions set"
        $result
    } -PSCmdlet $PSCmdlet
}