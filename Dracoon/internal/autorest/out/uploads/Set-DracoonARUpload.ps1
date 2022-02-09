function Set-DracoonARUpload {
<#
.SYNOPSIS
    Upload file

.DESCRIPTION
    ### Description:  
Upload a (chunk of a) file.

### Precondition:
Valid upload token.

### Postcondition:
Chunk uploaded.

### Further Information:
Range requests are supported.  

Following `Content-Types` are supported by this API:
* `multipart/form-data`
* provided `Content-Type`

For both file upload types set the correct `Content-Type` header and body.  

### Examples:  

* `multipart/form-data`
```
POST /api/v4/uploads/{token} HTTP/1.1

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
POST /api/v4/uploads/{token} HTTP/1.1

Header:
...
Content-Type: { ... }
...

Body:
raw content
```


.PARAMETER ContentRange
    Content-Range 

e.g. `bytes 0-999/3980`

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Upload token

.EXAMPLE
    PS C:\> Set-DracoonARUpload -Connection $connection -Token $token

    ### Description:  
Upload a (chunk of a) file.

### Precondition:
Valid upload token.

### Postcondition:
Chunk uploaded.

### Further Information:
Range requests are supported.  

Following `Content-Types` are supported by this API:
* `multipart/form-data`
* provided `Content-Type`

For both file upload types set the correct `Content-Type` header and body.  

### Examples:  

* `multipart/form-data`
```
POST /api/v4/uploads/{token} HTTP/1.1

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
POST /api/v4/uploads/{token} HTTP/1.1

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
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $ContentRange,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token
    )
    process {
        $__mapping = @{
            'ContentRange' = 'Content-Range'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('ContentRange') -Mapping $__mapping
        $__path = 'uploads/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}