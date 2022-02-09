function Get-DracoonARPublicShareUpload {
<#
.SYNOPSIS
    Request public Upload Share information

.DESCRIPTION
    ### Description:  
Provides information about the desired Upload Share.

### Precondition:
Only `userUserPublicKeyList` is returned to the users who owns one of the following permissions: <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage download share</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage upload share</span>

### Postcondition:
None.

### Further Information:
If no password is set, the returned information is reduced to the following attributes (if available):

* `name`
* `maxSlots`
* `createdAt`
* `isProtected`
* `isEncrypted`
* `showUploadedFiles`
* `userUserPublicKeyList` (if parent is end-to-end encrypted)

Only if the password is transmitted as `X-Sds-Share-Password` header, all values are returned.


.PARAMETER Access_key
    Access key

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER XSdsSharePassword
    Upload share password. Should be base64-encoded.

Plain X-Sds-Share-Passwords are *deprecated* and will be removed in the future

.EXAMPLE
    PS C:\> Get-DracoonARPublicShareUpload -Access_key $access_key -Connection $connection

    ### Description:  
Provides information about the desired Upload Share.

### Precondition:
Only `userUserPublicKeyList` is returned to the users who owns one of the following permissions: <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage download share</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage upload share</span>

### Postcondition:
None.

### Further Information:
If no password is set, the returned information is reduced to the following attributes (if available):

* `name`
* `maxSlots`
* `createdAt`
* `isProtected`
* `isEncrypted`
* `showUploadedFiles`
* `userUserPublicKeyList` (if parent is end-to-end encrypted)

Only if the password is transmitted as `X-Sds-Share-Password` header, all values are returned.


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Access_key,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsSharePassword
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'XSdsSharePassword' = 'X-Sds-Share-Password'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsSharePassword') -Mapping $__mapping
        $__path = 'public/shares/uploads/{access_key}' -Replace '{access_key}',$Access_key
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}