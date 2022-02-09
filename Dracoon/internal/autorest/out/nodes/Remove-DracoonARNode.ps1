function Remove-DracoonARNode {
<#
.SYNOPSIS
    Remove nodes

.DESCRIPTION
    ### Description:
Delete nodes (room, folder or file).

### Precondition:
Authenticated user with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; delete</span> permissions on supplied nodes (for folders or files) or on superordinated node (for rooms).

### Postcondition:
Nodes are deleted.

### Further Information:
Nodes **MUST** be in same parent.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Node_id
    Node ID

.EXAMPLE
    PS C:\> Remove-DracoonARNode -Node_id $node_id

    ### Description:
Delete node (room, folder or file).

### Precondition:
Authenticated user with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; delete</span> permissions on supplied nodes (for folders or files) or on superordinated node (for rooms).

### Postcondition:
Node gets deleted.

### Further Information:
None.

.EXAMPLE
    PS C:\> Remove-DracoonARNode -Connection $connection

    ### Description:
Delete nodes (room, folder or file).

### Precondition:
Authenticated user with <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; delete</span> permissions on supplied nodes (for folders or files) or on superordinated node (for rooms).

### Postcondition:
Nodes are deleted.

### Further Information:
Nodes **MUST** be in same parent.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeNode')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'removeNode')]
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
        $__path = 'nodes'
        if ($Node_id) { $__path += "/$Node_id" }
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}