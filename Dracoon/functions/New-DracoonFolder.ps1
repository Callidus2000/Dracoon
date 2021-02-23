function New-DracoonFolder {
    <#
    .SYNOPSIS
    Creates a new folder at the provided parent node.

    .DESCRIPTION
    API-POST /v4/nodes/folders

    .PARAMETER connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Name
    Name of the new room

    .PARAMETER ParentNodeId
    Node-ID  of the parent-node.

    .PARAMETER Notes
    Description notes for the folder

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    New-DracoonDataroom -Connection $connection -Name "MyFolder" -ParentRoomId $room.id

    Creates a folder within the defined room

    .NOTES
    Precondition:
    User has “create” permissions in current room.
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]

    param (
        [parameter(Mandatory)]
        $Connection,
        [parameter(Mandatory)]
        [string]$Name,
        [int]$ParentNodeId,
        [string]$Notes = "",
        [bool]$EnableException = $false
    )
    Write-PSFMessage "Create folder $Name in room $ParentNodeID"
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/nodes/folders"
        Body       = @{
            name                      = "$Name"
            parentId                  = $ParentNodeID
            notes                     = $Notes
        }
    }
    Invoke-PSFProtectedCommand -Action "Creating new folder" -Target "$RoomName" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "Folder successful created"
        $result
    } -PSCmdlet $PSCmdlet -EnableException $EnableException
}