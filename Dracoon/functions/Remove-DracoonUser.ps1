function Remove-DracoonUser {
    <#
    .SYNOPSIS
    Delete a user. API-DELETE /v4/users/{user_id}

    .DESCRIPTION
    Delete a user. API-DELETE /v4/users/{user_id}

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Id
    ID of the User which should be deleted.

    .PARAMETER DeleteLastAdminRooms
    If true, the function will check if the user is the last admin of any data room. If yes, the rooms will be removed first.

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
        $connection,
        [parameter(Mandatory, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [int]$Id,
        [bool]$DeleteLastAdminRooms = $false
    )
    process {
        $apiCallParameter = @{
            Connection = $Connection
            method     = "Delete"
            Path       = "/v4/users/$Id"
        }

        Write-PSFMessage "Lösche User $Id"
        if ($DeleteLastAdminRooms) {
            Write-PSFMessage "Check if the user is last admin of some rooms"
            $lastAdminRooms = Get-DracoonLastAdminRoom -Connection $connection -id $id
            if ($lastAdminRooms) {
                Write-PSFMessage "Removing $($lastAdminRooms.count) rooms"
                $lastAdminRooms | Remove-DracoonNode -Connection $connection
            }
        }
        Invoke-PSFProtectedCommand -Action "Removing User" -Target "$Id" -ScriptBlock {
            $result = Invoke-DracoonAPI @apiCallParameter
            Write-PSFMessage "User removed"
            $result
        } -PSCmdlet $PSCmdlet
    }
}