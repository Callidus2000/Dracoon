function Set-DracoonARNodeFileDownload {
<#
.SYNOPSIS
    Generate download URL

.DESCRIPTION
    ### Description:
Create a download URL to retrieve a file without `X-Sds-Auth-Token` Header.

### Precondition:
User with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions in parent room.

### Postcondition:
Download token is generated and returned.

### Further Information:
The token is necessary to access `downloads` ressources.

.PARAMETER File_id
    File ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARNodeFileDownload -File_id $file_id -Connection $connection

    ### Description:
Create a download URL to retrieve a file without `X-Sds-Auth-Token` Header.

### Precondition:
User with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions in parent room.

### Postcondition:
Download token is generated and returned.

### Further Information:
The token is necessary to access `downloads` ressources.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $File_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

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
        $__path = 'nodes/files/{file_id}/downloads' -Replace '{file_id}',$File_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}