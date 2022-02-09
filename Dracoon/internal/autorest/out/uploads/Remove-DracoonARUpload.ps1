function Remove-DracoonARUpload {
<#
.SYNOPSIS
    Cancel file upload

.DESCRIPTION
    ### Description:
Cancel file upload.

### Precondition:
Valid upload token.

### Postcondition:
Upload canceled, token invalidated and all already transfered chunks removed.

### Further Information:
It is recommended to notify the API about cancelled uploads if possible.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Upload token

.EXAMPLE
    PS C:\> Remove-DracoonARUpload -Connection $connection -Token $token

    ### Description:
Cancel file upload.

### Precondition:
Valid upload token.

### Postcondition:
Upload canceled, token invalidated and all already transfered chunks removed.

### Further Information:
It is recommended to notify the API about cancelled uploads if possible.

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
        $__path = 'uploads/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}