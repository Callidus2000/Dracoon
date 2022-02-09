function Remove-DracoonARNodeFavorite {
<#
.SYNOPSIS
    Unmark a node (room, folder or file) as favorite

.DESCRIPTION
    ### Description:
Unmarks a node (room, folder or file) as favorite.

### Precondition:
Authenticated user is allowed to <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128065; see</span> the node (i.e. `isBrowsable = true`).

### Postcondition:
A node gets unmarked as favorite.

### Further Information:
None.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Node_id
    Node ID

.EXAMPLE
    PS C:\> Remove-DracoonARNodeFavorite -Connection $connection -Node_id $node_id

    ### Description:
Unmarks a node (room, folder or file) as favorite.

### Precondition:
Authenticated user is allowed to <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128065; see</span> the node (i.e. `isBrowsable = true`).

### Postcondition:
A node gets unmarked as favorite.

### Further Information:
None.

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
        $__path = 'nodes/{node_id}/favorite' -Replace '{node_id}',$Node_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}