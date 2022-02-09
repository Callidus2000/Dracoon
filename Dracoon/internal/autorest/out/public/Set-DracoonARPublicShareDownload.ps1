function Set-DracoonARPublicShareDownload {
<#
.SYNOPSIS
    Generate download URL

.DESCRIPTION
    ### Description:
Generate a download URL to retrieve a shared file.

### Precondition:
None.

### Postcondition:
Download URL and token are generated and returned.

### Further Information:
Use `downloadUrl` the download `token` is deprecated.

.PARAMETER Access_key
    Access key

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARPublicShareDownload -Access_key $access_key -Connection $connection

    ### Description:
Generate a download URL to retrieve a shared file.

### Precondition:
None.

### Postcondition:
Download URL and token are generated and returned.

### Further Information:
Use `downloadUrl` the download `token` is deprecated.

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
        $Connection
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'public/shares/downloads/{access_key}' -Replace '{access_key}',$Access_key
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}