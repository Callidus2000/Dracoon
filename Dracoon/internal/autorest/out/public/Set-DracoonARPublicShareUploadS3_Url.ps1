function Set-DracoonARPublicShareUploadS3_Url {
<#
.SYNOPSIS
    Generate presigned URLs for S3 file upload

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Generate presigned URLs for S3 file upload.

### Precondition:
Valid upload ID

### Postcondition:
List of presigned URLs is returned.

### Further Information:
The size for each part must be >= 5 MB, except for the last part.  
The part number of the first part in S3 is 1 (not 0).  
Use HTTP method `PUT` for uploading bytes via presigned URL.

.PARAMETER Access_key
    Access key

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARPublicShareUploadS3_Url -Access_key $access_key -Upload_id $upload_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Generate presigned URLs for S3 file upload.

### Precondition:
Valid upload ID

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
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Access_key,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Upload_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat') -Mapping $__mapping
        $__path = 'public/shares/uploads/{access_key}/{upload_id}/s3_urls' -Replace '{access_key}',$Access_key -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}