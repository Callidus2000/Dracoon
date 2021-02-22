function Get-DracoonNodeAsZip {
    <#
    .SYNOPSIS
    Creates a ZIP archive from given NodeIDs and downloads it. API-POST /v4/nodes/zip

    .DESCRIPTION
    Creates a ZIP archive from given NodeIDs and downloads it.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER Id
    Array of NodeIDs which should be included into the ZIP file.

    .PARAMETER FileName
    Name of the downloaded ZIP file.

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    Get-DracoonNode -connection $connection -ParentID $roomId | Get-DracoonNodeAsZip -Connection $connection -FileName "myArchive.zip"
    Creates a ZIP archive containing all files of the given room.

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        $Connection,
        [parameter(Mandatory, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [int[]]$Id,
        [parameter(Mandatory)]
        $FileName,
        $EnableException = $false
    )
    begin {
        $idArray = @()
    }
    process {
        $idArray += $id
    }
    end {
        Write-PSFMessage "Download ID: $($idArray -join ",")"
        $apiCallParameter = @{
            Connection = $Connection
            method     = "Post"
            Path       = "/v4/nodes/zip"
            Body       = @{
                nodeIds = $idArray
            }
        }

        $result = Invoke-DracoonAPI @apiCallParameter
        if ($result) {
            Invoke-PSFProtectedCommand -Action "Downloading" -Target $FileName -ScriptBlock {
                Invoke-WebRequest -Uri $result.downloadUrl -OutFile $FileName -ErrorAction Stop
            } -PSCmdlet $PSCmdlet -EnableException $EnableException -RetryCount 4 -RetryWait 5
        }
    }
}