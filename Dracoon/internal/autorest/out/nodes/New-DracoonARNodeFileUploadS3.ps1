function New-DracoonARNodeFileUploadS3 {
<#
.SYNOPSIS
    Complete S3 file upload

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Finishes a S3 file upload and closes the corresponding upload channel.

### Precondition:
An upload channel has been created, data has been transmitted and user has to be the creator of the upload channel

### Postcondition:
Upload channel is closed. S3 multipart upload request is completed.

### Further Information:
Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARNodeFileUploadS3 -Upload_id $upload_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Finishes a S3 file upload and closes the corresponding upload channel.

### Precondition:
An upload channel has been created, data has been transmitted and user has to be the creator of the upload channel

### Postcondition:
Upload channel is closed. S3 multipart upload request is completed.

### Further Information:
Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

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
        $__path = 'nodes/files/uploads/{upload_id}/s3' -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}