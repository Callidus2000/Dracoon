function Publish-DracoonFile {
    <#
    .SYNOPSIS
    Uploads a file to an already existing dataroom.

    .DESCRIPTION
    Uploads a file to an already existing dataroom.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER FilePath
    Filepath of the file which should get uploaded.

    .PARAMETER ParentNodeId
    ID of the target room.

    .PARAMETER ExpirationDate
    Optional expiration date for the file.

    .PARAMETER Classification
    Classification of the file.

    .PARAMETER Notes
    Notes for the file

    .PARAMETER ResolutionStrategy
    If the file already exists: Should it be overwritten (overwrite) ord should it be uploaded with an automatic name (autorename)

    .PARAMETER EnableException
    If set to $true errors throw an exception

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    Publish-DracoonFile -Connection $connection -FilePath $fileName -ParentNodeId $roomId
    Performs an upload of $fileName

    .NOTES
    Uploads consist of three steps:
    -Initialization - Announces the upload and creates a placeholder
    -Upload - Binary transfer of the file
    -Closing the upload - Tell Dracoon that the data has completely transfered
    #>
    [CmdletBinding(DefaultParameterSetName = "Upload", SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(mandatory = $true)]
        [Dracoon]$Connection,
        [parameter(mandatory = $true)]
        [string]$FilePath,
        [parameter(mandatory = $true)]
        [int]$ParentNodeId,
        [datetime]$ExpirationDate,
        [int]$Classification = 2,
        [string]$Notes = "",
        [ValidateSet("overwrite", "autorename")]
        [string]$ResolutionStrategy = "autorename",
        [bool]$EnableException = $false
    )
    $fullFilePath = Get-Item $FilePath -ErrorAction SilentlyContinue
    Write-PSFMessage "Upload of $FilePath ($fullFilePath), ResolutionStrategy=$ResolutionStrategy"
    if ($fullFilePath) {
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

        Write-PSFMessage "Init: $($apiCallParameter|convertTo-json -depth 10)" -Level Debug
        Invoke-PSFProtectedCommand -Action "Initialize Upload, Open Upload Channel" -Target $fullFilePath.Name -ScriptBlock {
            $initUpload = Invoke-DracoonAPI @apiCallParameter
            Write-PSFMessage "initUpload=$($initUpload|ConvertTo-Json -Depth 5)" -Level Debug
            Invoke-PSFProtectedCommand -Action "Upload File-Data" -Target $initUpload.token -ScriptBlock {
                $apiCallParameter = @{
                    Connection  = $Connection
                    method      = "Post"
                    Path        = "/v4/uploads/$($initUpload.token)"
                    ContentType = "application/octet-stream"
                    InFile      = $fullFilePath.FullName
                }
                $result = Invoke-DracoonAPI @apiCallParameter
                # $result = Invoke-RestMethod $initUpload.uploadUrl -ContentType "application/octet-stream" -Method Post -Headers $connection.headers -InFile $fullFilePath.FullName

                Write-PSFMessage $result
                Invoke-PSFProtectedCommand -Action "Close Upload Channel" -Target $initUpload.token -ScriptBlock {
                    $apiCallParameter = @{
                        Connection = $Connection
                        method     = "Put"
                        Path       = "/v4/uploads/$($initUpload.token)"
                        Body=@{
                            resolutionStrategy = $ResolutionStrategy
                        }
                    }
                    $result = Invoke-DracoonAPI @apiCallParameter
                    # $result = $this.Invoke(("/v4/uploads/{0}" -f $initUpload.token), $null, [Microsoft.Powershell.Commands.WebRequestMethod]::Put, $false)
                    Write-PSFMessage "Upload successfull closed"
                    return $result
                } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
            } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
            if (Test-PSFFunctionInterrupt) {
                Write-PSFMessage "Error uploading the file"
                Invoke-PSFProtectedCommand -Action 'Cleanup $initUpload.token' -Target $initUpload.token -ScriptBlock {
                    $apiCallParameter = @{
                        Connection = $Connection
                        method     = "Delete"
                        Path       = "/v4/uploads/$($initUpload.token)"
                    }
                    Invoke-DracoonAPI @apiCallParameter
                } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
            }
        } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
        if (Test-PSFFunctionInterrupt) { return }
    }
    elseif ($EnableException) {
        Write-PSFMessage "File not found: $FilePath"
        throw "File not found: $FilePath"
    }
}