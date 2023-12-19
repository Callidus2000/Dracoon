function Publish-DracoonFile {
    <#
    .SYNOPSIS
    Uploads a file to an already existing dataroom.

    .DESCRIPTION
    Uploads a file to an already existing dataroom.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

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
     -For s3: Query the s3 Upload URL
    -Upload - Binary transfer of the file
    -Closing the upload - Tell Dracoon that the data has completely transfered
    #>
    [CmdletBinding(DefaultParameterSetName = "Upload", SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]

    param (
        [parameter(mandatory = $true)]
        $Connection,
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
    $directS3upload = $connection.systemInfo.s3EnforceDirectUpload -eq 'True'
    Write-PSFMessage "Upload of $FilePath ($fullFilePath), ResolutionStrategy=$ResolutionStrategy, directS3upload=$directS3upload"
    if ($fullFilePath) {
        $apiCallParameter = @{
            Connection = $Connection
            method     = "Post"
            Path       = "/v4/nodes/files/uploads"
            Body       = @{
                "parentId"       = $parentNodeId
                "directS3Upload" = $directS3upload
                "name"           = $fullFilePath.Name
                "classification" = $Classification
                "size"           = $fullFilePath.length
                "expiration"     = @{
                    "enableExpiration" = $false
                    "expireAt"         = "2018-01-01T00:00:00"
                }
                "notes"          = $Notes
            }
        }
        if ($ExpirationDate) {
            $apiCallParameter.Body.expiration.enableExpiration = 'true'
            $apiCallParameter.Body.expiration.expireAt = $ExpirationDate.ToString('yyyy-MM-ddT00:00:00')
        }

        Write-PSFMessage "Init: $($apiCallParameter|convertTo-json -depth 10)" -Level Debug
        Invoke-PSFProtectedCommand -Action "Initialize Upload" -Target $fullFilePath.Name -ScriptBlock {
            $initUploadResult = Invoke-DracoonAPI @apiCallParameter
            if ($directS3upload) {
                Invoke-PSFProtectedCommand -Action "Get S3 direct upload URL" -Target $fullFilePath.Name -ScriptBlock {
                    $apiCallParameter = @{
                        Connection = $Connection
                        method     = "Post"
                        Path       = "/v4/nodes/files/uploads/$($initUploadResult.uploadId)/s3_urls"
                        Body       = @{
                            "firstPartNumber" = 1
                            "lastPartNumber"  = 1
                            "size"            = $fullFilePath.length
                        }
                    }
                    $initUploadS3 = Invoke-DracoonAPI @apiCallParameter
                    $s3UploadUrl = $initUploadS3.urls.url
                    $s3UploadUrl | Out-Null #Workarond of the pester tests
                }
            }
            Write-PSFMessage "initUploadResult=$($initUploadResult|ConvertTo-Json -Depth 5)" -Level Debug
            Invoke-PSFProtectedCommand -Action "Upload File-Data" -Target $initUploadResult.token -ScriptBlock {
                if ($directS3upload) {
                    $uploadResult = Invoke-RestMethod -Uri "$s3UploadUrl" -ContentType "application/octet-stream" -Method Put -InFile $fullFilePath.FullName -ResponseHeadersVariable respHeaders
                    $eTag = $respHeaders.Etag.Trim('"')
                }
                else {
                    $apiCallParameter = @{
                        Connection  = $Connection
                        method      = "Post"
                        Path        = "/v4/uploads/$($initUploadResult.token)"
                        ContentType = "application/octet-stream"
                        InFile      = $fullFilePath.FullName
                    }
                    $uploadResult = Invoke-DracoonAPI @apiCallParameter
                }

                Write-PSFMessage $uploadResult
                Invoke-PSFProtectedCommand -Action "Close Upload Channel" -Target $initUploadResult.token -ScriptBlock {
                    $apiCallParameter = @{
                        Connection = $Connection
                        method     = "Put"
                        Path       = "/v4/uploads/$($initUploadResult.token)"
                        Body       = @{
                            resolutionStrategy = $ResolutionStrategy
                        }
                    }
                    if ($directS3upload) {
                        $apiCallParameter.Path = "/v4/nodes/files/uploads/$($initUploadResult.uploadId)/s3"
                        $apiCallParameter.Body.parts = @(
                            @{
                                partEtag   = $eTag
                                partNumber = 1
                            }
                        )
                    }
                    $result = Invoke-DracoonAPI @apiCallParameter
                    # $result = $this.Invoke(("/v4/uploads/{0}" -f $initUploadResult.token), $null, [Microsoft.Powershell.Commands.WebRequestMethod]::Put, $false)
                    Write-PSFMessage "Upload successfull closed"
                    return $result
                } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
            } -PSCmdlet $PSCmdlet -Verbose -EnableException $EnableException
            if (Test-PSFFunctionInterrupt) {
                Write-PSFMessage "Error uploading the file"
                Invoke-PSFProtectedCommand -Action 'Cleanup $initUploadResult.token' -Target $initUploadResult.token -ScriptBlock {
                    $apiCallParameter = @{
                        Connection = $Connection
                        method     = "Delete"
                        Path       = "/v4/uploads/$($initUploadResult.token)"
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