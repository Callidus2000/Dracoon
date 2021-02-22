function Remove-DracoonNode {
    <#
    .SYNOPSIS
    Delete node (room, folder or file). API-DELETE /v4/nodes/{node_id}

    .DESCRIPTION
    Delete node (room, folder or file).

    Precondition:
    Authenticated user with “delete” permissions on:

    supplied nodes (for folders or files)
    superordinated node (for rooms)
    Effects:
    Node gets deleted.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER NodeId
    ID of the node which should be deleted.

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    $rooms = Get-DracoonAuditDataroom -connection $connection -filter "nodeName:cn:DEMO"
    $hubbaRooms| Remove-DracoonNode -connection $connection
    Queries all rooms with "DEMO" within the nodeName and deletes them.

    Remove-DracoonNode -connection $connection -NodeId 15
    Deletes the node with ID 15.

    .NOTES
    General notes
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [parameter(Mandatory)]
        $connection,
        [parameter(Mandatory, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias("ID")]
        [int]$NodeId
    )
    process {
        $apiCallParameter = @{
            Connection = $Connection
            method     = "Delete"
            Path       = "/v4/nodes/$NodeId"
        }
        Invoke-PSFProtectedCommand -Action "Removing Node" -Target "$Id" -ScriptBlock {
            $result = Invoke-DracoonAPI @apiCallParameter
            Write-PSFMessage "Node removed"
            $result
        } -PSCmdlet $PSCmdlet
    }
}