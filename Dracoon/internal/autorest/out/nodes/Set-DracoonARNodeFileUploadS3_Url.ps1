function Set-DracoonARNodeFileUploadS3_Url {
<#
.SYNOPSIS
    Generate presigned URLs for S3 file upload

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Generate presigned URLs for S3 file upload.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
List of presigned URLs is returned.

### Further Information:
The size for each part must be >= 5 MB, except for the last part.  
The part number of the first part in S3 is 1 (not 0).  
Use HTTP method `PUT` for uploading bytes via presigned URL.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARNodeFileUploadS3_Url -Upload_id $upload_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Generate presigned URLs for S3 file upload.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
List of presigned URLs is returned.

### Further Information:
The size for each part must be >= 5 MB, except for the last part.  
The part number of the first part in S3 is 1 (not 0).  
Use HTTP method `PUT` for uploading bytes via presigned URL.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Upload_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/files/uploads/{upload_id}/s3_urls' -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}