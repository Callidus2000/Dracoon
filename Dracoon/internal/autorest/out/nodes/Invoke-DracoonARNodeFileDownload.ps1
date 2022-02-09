function Invoke-DracoonARNodeFileDownload {
<#
.SYNOPSIS
    Download file

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.3.0</h3>

### Use `downloads` API

### Description:
Download a file.

### Precondition:
User with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions in parent room.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported for details.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER File_id
    File ID

.PARAMETER Inline
    Use Content-Disposition: `inline` instead of `attachment`

.PARAMETER Generic_mimetype
    Always return `application/octet-stream` instead of specific mimetype

.PARAMETER Range
    Range 

e.g. `bytes=0-999/3980`

.EXAMPLE
    PS C:\> Invoke-DracoonARNodeFileDownload -Connection $connection -File_id $file_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.3.0</h3>

### Use `downloads` API

### Description:
Download a file.

### Precondition:
User with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions in parent room.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported for details.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $File_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Inline,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Generic_mimetype,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Range
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
            'Inline' = 'inline'
            'Generic_mimetype' = 'generic_mimetype'
            'Range' = 'Range'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Inline','Generic_mimetype') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','Range') -Mapping $__mapping
        $__path = 'nodes/files/{file_id}/downloads' -Replace '{file_id}',$File_id
        Invoke-DracoonAPI -Path $__path -Method head -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}