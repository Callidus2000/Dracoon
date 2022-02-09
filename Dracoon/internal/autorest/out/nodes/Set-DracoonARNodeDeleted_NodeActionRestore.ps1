function Set-DracoonARNodeDeleted_NodeActionRestore {
<#
.SYNOPSIS
    Restore deleted nodes

.DESCRIPTION
    ### Description:  
Restore a list of deleted nodes.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; create</span> permissions in parent room and <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; restore recycle bin</span> permissions.

### Postcondition:
The selected files are moved from the recycle bin to the chosen productive container.

### Further Information:
If no parent ID is provided, the node is restored to its previous location.  
The default resolution strategy is `autorename` that adds numbers to the file name until the conflict is solved.  
If an existing file is overwritten, it is moved to the recycle bin instead of the restored one.

Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Set-DracoonARNodeDeleted_NodeActionRestore -Connection $connection

    ### Description:  
Restore a list of deleted nodes.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; create</span> permissions in parent room and <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; restore recycle bin</span> permissions.

### Postcondition:
The selected files are moved from the recycle bin to the chosen productive container.

### Further Information:
If no parent ID is provided, the node is restored to its previous location.  
The default resolution strategy is `autorename` that adds numbers to the file name until the conflict is solved.  
If an existing file is overwritten, it is moved to the recycle bin instead of the restored one.

Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/deleted_nodes/actions/restore'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}