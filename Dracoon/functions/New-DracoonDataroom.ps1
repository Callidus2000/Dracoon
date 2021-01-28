function New-DracoonDataroom {
    <#
    .SYNOPSIS
    Creates a new room at the provided parent node.
    Creation of top level rooms provided.

    .DESCRIPTION
    API-POST /v4/nodes/rooms

    .PARAMETER connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER RoomName
    Name of the new room

    .PARAMETER ParentNodeId
    Node-ID  of the parent-node, 0 for Creation of top level rooms

    .PARAMETER AdminUserId
    Array of user-ids of room admins

    .PARAMETER AdminGroupId
    Array of user-ids of room admin groups

    .PARAMETER RecycleBinRetentionPeriod
    How many days should files be kept in the recycle bin.

    .PARAMETER InheritPermissions
    Room inherits the permissions of the parent room

    .PARAMETER Notes
    Description notes for the room

    .PARAMETER NewGroupMemberAcceptance
    Do new admin group members have to be released? Default is "autoallow"

    .PARAMETER Quota
    Quota for the new room in bytes. 0 for no quota.

    .PARAMETER HasActivitiesLog
    Is the activity log enabled for the room?

    .PARAMETER Classification
    Nummerical classification.

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    To be added
    in the Future

    .NOTES
    Precondition:
    User has “manage” permissions in the parent room.
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(Mandatory)]
        [Dracoon]$Connection,
        [parameter(Mandatory)]
        [string]$RoomName,
        [int]$ParentNodeId,
        [parameter(Mandatory)]
        [array]$AdminUserId,
        [array]$AdminGroupId,
        [int]$RecycleBinRetentionPeriod = 14,
        [bool]$InheritPermissions = $false,
        [string]$Notes = "",
        [ValidateSet("autoallow", "pending")]
        [String]$NewGroupMemberAcceptance = "autoallow",
        [int]$Quota = 0,
        [bool]$HasActivitiesLog = $true,
        $Classification=2
    )
    Write-PSFMessage "Erzeuge Datenraum $RoomName"
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/nodes/rooms"
        Body       = @{
            name                      = "$RoomName"
            recycleBinRetentionPeriod = $RecycleBinRetentionPeriod
            quota                     = $Quota
            inheritPermissions        = $InheritPermissions
            adminIds                  = $AdminUserId
            adminGroupIds             = $adminGroupId
            newGroupMemberAcceptance  = $NewGroupMemberAcceptance
            notes                     = $Notes
            hasActivitiesLog          = $HasActivitiesLog
            classification            = $Classification
            hasRecycleBin             = $true
        }
        # EnablePaging=$true
    }
    if ($parentNodeId -gt 0) {
        $apiCallParameter.body.parentId = $parentNodeId
    }
    Invoke-PSFProtectedCommand -Action "Creating new dataroom" -Target "$RoomName" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "User erfolgreich angelegt"
        $result
    } -PSCmdlet $PSCmdlet
}