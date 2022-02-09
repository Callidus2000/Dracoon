function Get-DracoonARNodeFileUpload {
<#
.SYNOPSIS
    Request status of S3 file upload

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Request status of a S3 file upload.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
Status of S3 multipart upload request is returned.

### Further Information:
None.

### Possible errors:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Http Status | Error Code | Description |
| :--- | :--- | :--- |
| `400 Bad Request` | `-80000` | Mandatory fields cannot be empty |
| `400 Bad Request` | `-80001` | Invalid positive number |
| `400 Bad Request` | `-80002` | Invalid number |
| `400 Bad Request` | `-40001` | (Target) room is not encrypted |
| `400 Bad Request` | `-40755` | Bad file name |
| `400 Bad Request` | `-40763` | File key must be set for an upload into encrypted room |
| `400 Bad Request` | `-50506` | Exceeds the number of files for this Upload Share |
| `403 Forbidden` |  | Access denied |
| `404 Not Found` | `-20501` | Upload not found |
| `404 Not Found` | `-40000` | Container not found |
| `404 Not Found` | `-41000` | Node not found |
| `404 Not Found` | `-70501` | User not found |
| `409 Conflict` | `-40010` | Container cannot be overwritten |
| `409 Conflict` |  | File cannot be overwritten |
| `500 Internal Server Error` |  | System Error |
| `502 Bad Gateway` |  | S3 Error |
| `502 Insufficient Storage` | `-50504` | Exceeds the quota for this Upload Share |
| `502 Insufficient Storage` | `-40200` | Exceeds the free node quota in room |
| `502 Insufficient Storage` | `-90200` | Exceeds the free customer quota |
| `502 Insufficient Storage` | `-90201` | Exceeds the free customer physical disk space |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Get-DracoonARNodeFileUpload -Upload_id $upload_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.15.0</h3>

### Description:
Request status of a S3 file upload.

### Precondition:
An upload channel has been created and user has to be the creator of the upload channel.

### Postcondition:
Status of S3 multipart upload request is returned.

### Further Information:
None.

### Possible errors:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Http Status | Error Code | Description |
| :--- | :--- | :--- |
| `400 Bad Request` | `-80000` | Mandatory fields cannot be empty |
| `400 Bad Request` | `-80001` | Invalid positive number |
| `400 Bad Request` | `-80002` | Invalid number |
| `400 Bad Request` | `-40001` | (Target) room is not encrypted |
| `400 Bad Request` | `-40755` | Bad file name |
| `400 Bad Request` | `-40763` | File key must be set for an upload into encrypted room |
| `400 Bad Request` | `-50506` | Exceeds the number of files for this Upload Share |
| `403 Forbidden` |  | Access denied |
| `404 Not Found` | `-20501` | Upload not found |
| `404 Not Found` | `-40000` | Container not found |
| `404 Not Found` | `-41000` | Node not found |
| `404 Not Found` | `-70501` | User not found |
| `409 Conflict` | `-40010` | Container cannot be overwritten |
| `409 Conflict` |  | File cannot be overwritten |
| `500 Internal Server Error` |  | System Error |
| `502 Bad Gateway` |  | S3 Error |
| `502 Insufficient Storage` | `-50504` | Exceeds the quota for this Upload Share |
| `502 Insufficient Storage` | `-40200` | Exceeds the free node quota in room |
| `502 Insufficient Storage` | `-90200` | Exceeds the free customer quota |
| `502 Insufficient Storage` | `-90201` | Exceeds the free customer physical disk space |

</details>

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
        $__path = 'nodes/files/uploads/{upload_id}' -Replace '{upload_id}',$Upload_id
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}