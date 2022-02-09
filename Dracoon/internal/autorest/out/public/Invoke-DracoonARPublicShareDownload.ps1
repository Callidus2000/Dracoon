function Invoke-DracoonARPublicShareDownload {
<#
.SYNOPSIS
    Download file with token

.DESCRIPTION
    ### Description:  
Download a file (or zip archive if target is a folder or room).

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported.  
Range requests are illegal for zip archive download.

.PARAMETER Access_key
    Access key

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Download token

.PARAMETER Inline
    Use Content-Disposition: `inline` instead of `attachment`

.PARAMETER Generic_mimetype
    Always return `application/octet-stream` instead of specific mimetype

.PARAMETER Range
    Range 

e.g. `bytes=0-999`

.EXAMPLE
    PS C:\> Invoke-DracoonARPublicShareDownload -Access_key $access_key -Connection $connection -Token $token

    ### Description:  
Download a file (or zip archive if target is a folder or room).

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported.  
Range requests are illegal for zip archive download.

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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token,

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
            'Connection' = 'Connection'
            'Inline' = 'inline'
            'Generic_mimetype' = 'generic_mimetype'
            'Range' = 'Range'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Inline','Generic_mimetype') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Range') -Mapping $__mapping
        $__path = 'public/shares/downloads/{access_key}/{token}' -Replace '{access_key}',$Access_key -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method head -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}