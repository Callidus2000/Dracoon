function Set-DracoonARPublicShareUpload {
<#
.SYNOPSIS
    Create new file upload channel

.DESCRIPTION
    ### Description:  
Create a new upload channel.

### Precondition:
None.

### Postcondition:
Upload channel is created and corresponding upload URL, token & upload ID are returned.

### Further Information:
Use `uploadUrl` the upload `token` is deprecated.  

Please provide the size of the intended upload so that the quota can be checked in advanced and no data is transferred unnecessarily.

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


.PARAMETER Access_key
    Access key

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARPublicShareUpload -Access_key $access_key -Connection $connection

    ### Description:  
Create a new upload channel.

### Precondition:
None.

### Postcondition:
Upload channel is created and corresponding upload URL, token & upload ID are returned.

### Further Information:
Use `uploadUrl` the upload `token` is deprecated.  

Please provide the size of the intended upload so that the quota can be checked in advanced and no data is transferred unnecessarily.

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


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
        $__path = 'public/shares/uploads/{access_key}' -Replace '{access_key}',$Access_key
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}