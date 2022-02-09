function Get-DracoonARDownload {
<#
.SYNOPSIS
    Download file

.DESCRIPTION
    ### Description:
Download a file.

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported.

.PARAMETER Range
    Range 

e.g. `bytes=0-999`

.PARAMETER Inline
    Use Content-Disposition: `inline` instead of `attachment`

.PARAMETER Generic_mimetype
    Always return `application/octet-stream` instead of specific mimetype

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Download token

.EXAMPLE
    PS C:\> Get-DracoonARDownload -Connection $connection -Token $token

    ### Description:
Download a file.

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Range requests are supported.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Range,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Inline,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Generic_mimetype,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token
    )
    process {
        $__mapping = @{
            'Range' = 'Range'
            'Inline' = 'inline'
            'Generic_mimetype' = 'generic_mimetype'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Inline','Generic_mimetype') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Range') -Mapping $__mapping
        $__path = 'downloads/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}