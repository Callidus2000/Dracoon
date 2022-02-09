function Remove-DracoonARNodeDeleted_Node {
<#
.SYNOPSIS
    Empty recycle bin

.DESCRIPTION
    ### Description:  
Empty a recycle bin.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; delete recycle bin</span> permissions in parent room.

### Postcondition:
All files in the recycle bin are permanently removed.

### Further Information:
Actually removes the previously deleted files from the system.  
**This action is irreversible.**

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Node_id
    Room ID

.EXAMPLE
    PS C:\> Remove-DracoonARNodeDeleted_Node -Connection $connection -Node_id $node_id

    ### Description:  
Empty a recycle bin.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; delete recycle bin</span> permissions in parent room.

### Postcondition:
All files in the recycle bin are permanently removed.

### Further Information:
Actually removes the previously deleted files from the system.  
**This action is irreversible.**

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
        $Node_id
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/{node_id}/deleted_nodes' -Replace '{node_id}',$Node_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}