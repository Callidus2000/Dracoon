function Set-DracoonARNodeFileUpload {
<#
.SYNOPSIS
    Create new file upload channel

.DESCRIPTION
    ### Description:
This endpoint creates a new upload channel which is the first step in any file upload workflow.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; create</span> permissions in the parent container (room or folder).

### Postcondition:
A new upload channel for a file is created.  
Its ID and an upload token are returned.

### Further Information:
The upload ID is used for uploads with `X-Sds-Auth-Token` header, the upload token can be used for uploads without authentication header.

Please provide the size of the intended upload so that the quota can be checked in advanced and no data is transferred unnecessarily.

Notes are limited to **255** characters.

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


.PARAMETER ContentRange
    Content-Range 

e.g. `bytes 0-999/3980`

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Upload_id
    Upload channel ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARNodeFileUpload -Connection $connection

    ### Description:
This endpoint creates a new upload channel which is the first step in any file upload workflow.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; create</span> permissions in the parent container (room or folder).

### Postcondition:
A new upload channel for a file is created.  
Its ID and an upload token are returned.

### Further Information:
The upload ID is used for uploads with `X-Sds-Auth-Token` header, the upload token can be used for uploads without authentication header.

Please provide the size of the intended upload so that the quota can be checked in advanced and no data is transferred unnecessarily.

Notes are limited to **255** characters.

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


.EXAMPLE
    PS C:\> Set-DracoonARNodeFileUpload -Upload_id $upload_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.9.0</h3>

### Use `uploads` API

### Description:  
Uploads a file or parts of it in an active upload channel.

### Precondition:
An upload channel has been created.

### Postcondition:
A file or parts of it are uploaded to a temporary location.

### Further Information:
This endpoints supports chunked upload.  

Following `Content-Types` are supported by this API:
* `multipart/form-data`
* provided `Content-Type`   

For both file upload types set the correct `Content-Type` header and body.  

### Examples:  

* `multipart/form-data`
```
POST /api/v4/nodes/files/uploads/{upload_id} HTTP/1.1

Header:
...
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
...

Body:
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="file"; filename="file.txt"
Content-Type: text/plain

Content of file.txt
------WebKitFormBoundary7MA4YWxkTrZu0gW--
```

* any other `Content-Type`  
```
POST /api/v4/nodes/files/uploads/{upload_id}  HTTP/1.1

Header:
...
Content-Type: { ... }
...

Body:
raw content
```

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'uploadFileAsMultipart')]
        [string]
        $ContentRange,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'uploadFileAsMultipart')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'uploadFileAsMultipart')]
        [string]
        $Upload_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'ContentRange' = 'Content-Range'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('ContentRange','XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/files/uploads'
        if ($Upload_id) { $__path += "/$Upload_id" }
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}