#     [PSCustomObject]UploadFile([string]$fullFilePath, [int]$parentNodeId) {
#         return $this.UploadFile((get-item $fullFilePath), $parentNodeId)
#     }
#     [PSCustomObject]UploadFile([System.IO.FileSystemInfo]$fullFilePath, [int]$parentNodeId) {
#         $result = $null
#         Write-PSFMessage "Lade Datei hoch: $fullFilePath"
#         $parameter = @{"parentId" = $parentNodeId; "name" = $fullFilePath.Name; "classification" = 2; "size" = $fullFilePath.length; "expiration" = @{"enableExpiration" = $false; "expireAt" = "2018-01-01T00:00:00" }; "notes" = "" }
#         $initUpload = $this.InvokePost("/v4/nodes/files/uploads", $parameter)
#         try {
#             $result = Invoke-RestMethod $initUpload.uploadUrl -ContentType "application/octet-stream" -Method Post -Headers $this.headers -InFile $fullFilePath.FullName

#             Write-PSFMessage $result
#             $result = $this.Invoke(("/v4/uploads/{0}" -f $initUpload.token), $null, [Microsoft.Powershell.Commands.WebRequestMethod]::Put, $false)
#         }
#         catch {
#             Write-PSFMessage "Fehler $_"
#             $this.InvokeDelete(("/v4/uploads/{0}" -f $initUpload.token))
#             throw $_
#         }
#         return $result
#     }
function Publish-DracoonFile {
    <#
    .SYNOPSIS
    Create a new user.

    .DESCRIPTION
    Create a new user. Two option sets are possible: Mail-User (internal authentication) or Active Directory based authentification.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

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
    [CmdletBinding(DefaultParameterSetName = "Upload", SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(mandatory = $true, ParameterSetName = "Upload")]
        [Dracoon]$Connection,
        [parameter(mandatory = $true, ParameterSetName = "Upload")]
        [string]$FilePath,
        [parameter(mandatory = $true, ParameterSetName = "Upload")]
        [int]$ParentNodeId,
        [datetime]$ExpirationDate,
        [int]$Classification = 2,
        [string]$Notes = "",
        [bool]$EnableException=$false
    )
    $fullFilePath = Get-Item $FilePath
    Write-PSFMessage "Upload of $fullFilePath"
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/nodes/files/uploads"
        Body       = @{"parentId" = $parentNodeId
            "name"                = $fullFilePath.Name
            "classification"      = $Classification
            "size"                = $fullFilePath.length
            "expiration"          = @{
                "enableExpiration" = $false
                "expireAt"         = "2018-01-01T00:00:00"
            }
            "notes"               = $Notes
        }
    }
    if ($ExpirationDate) {
        $apiCallParameter.Body.expiration.enableExpiration = 'true'
        $apiCallParameter.Body.expiration.expireAt = $ExpirationDate.ToString('yyyy-MM-ddT00:00:00')
    }

    write-psfmessage "Init: $($apiCallParameter|convertTo-json -depth 10)"
    Invoke-PSFProtectedCommand -Action "Initialize Upload" -Target $fullFilePath.Name -ScriptBlock {
        $initUpload = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "initUpload=$($initUpload|ConvertTo-Json -Depth 5)"
        try {
            $apiCallParameter = @{
                Connection  = $Connection
                method      = "Post"
                Path        = $initUpload.uploadUrl -replace "^.*/api"
                ContentType = "application/octet-stream"
                InFile      = $fullFilePath.FullName
            }
            $result = Invoke-DracoonAPI @apiCallParameter
            # $result = Invoke-RestMethod $initUpload.uploadUrl -ContentType "application/octet-stream" -Method Post -Headers $connection.headers -InFile $fullFilePath.FullName

            Write-PSFMessage $result
            $apiCallParameter = @{
                Connection  = $Connection
                method      = "Put"
                Path        = "/v4/uploads/$($initUpload.token)"
            }
            $result = Invoke-DracoonAPI @apiCallParameter
            # $result = $this.Invoke(("/v4/uploads/{0}" -f $initUpload.token), $null, [Microsoft.Powershell.Commands.WebRequestMethod]::Put, $false)
        }
        catch {
            Write-PSFMessage "Fehler $_"
            $apiCallParameter = @{
                Connection = $Connection
                method     = "Delete"
                Path       = "/v4/uploads/$($initUpload.token)"
            }
            Invoke-DracoonAPI @apiCallParameter
            throw $_
        }
        return $result
        Write-PSFMessage "Upload successfull initialized"
        $result
    } -PSCmdlet $PSCmdlet -Confirm:$false -Verbose
    if (Test-PSFFunctionInterrupt) { return }
}