function Set-DracoonARShareUpload {
<#
.SYNOPSIS
    Create new Upload Share

.DESCRIPTION
    ### Description:
Create a new Upload Share (aka File Request).

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage upload share</span> permissions on target container.

### Postcondition:
Upload Share is created.

### Further Information:

* `name` is limited to **150** characters.
* `notes` are limited to **255** characters.
* `password` is limited to **1024** characters.

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]  

Use `POST /shares/uploads/{share_id}/email` API for sending emails.


.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARShareUpload -Connection $connection

    ### Description:
Create a new Upload Share (aka File Request).

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage upload share</span> permissions on target container.

### Postcondition:
Upload Share is created.

### Further Information:

* `name` is limited to **150** characters.
* `notes` are limited to **255** characters.
* `password` is limited to **1024** characters.

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]  

Use `POST /shares/uploads/{share_id}/email` API for sending emails.


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsAuthToken') -Mapping $__mapping
        $__path = 'shares/uploads'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}