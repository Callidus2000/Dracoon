function Get-DracoonARDownloadZip {
<#
.SYNOPSIS
    Download ZIP archive

.DESCRIPTION
    ### Description:
Download multiple files in a ZIP archive.

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Create a download token with `POST /nodes/zip` API.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Download token

.EXAMPLE
    PS C:\> Get-DracoonARDownloadZip -Connection $connection -Token $token

    ### Description:
Download multiple files in a ZIP archive.

### Precondition:
Valid download token.

### Postcondition:
Stream is returned.

### Further Information:
Create a download token with `POST /nodes/zip` API.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'downloads/zip/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}