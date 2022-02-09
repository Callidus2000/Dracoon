function Get-DracoonARNodeDeleted_NodeVersion {
<#
.SYNOPSIS
    Request deleted versions of nodes

.DESCRIPTION
    ### Description:  
Retrieve all deleted versions of a node.

### Precondition:
User can access parent room and has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read recycle bin</span> permissions.

### Postcondition:
List of deleted versions of a node is returned.

### Further Information:
The node is identified by three parameters:
* parent ID (only room IDs are accepted as parent ID since only rooms may have a recycle bin.)
* name
* type (file, folder).

Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`expireAt:desc`  
Sort by `expireAt` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `expireAt` | Expiration date |
| `accessedAt` | Last access date |
| `size` | Node size |
| `classification` | Classification ID:<ul><li>1 - public</li><li>2 - internal</li><li>3 - confidential</li><li>4 - strictly confidential</li></ul> |
| `createdAt` | Creation date |
| `createdBy` | Creator first name, last name |
| `updatedAt` | Last modification date |
| `updatedBy` | Last modifier first name, last name |
| `deletedAt` | Deleted date |
| `deletedBy` | Deleter first name, last name |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Sort
    Sort string

.PARAMETER Type
    Node type

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Offset
    Range offset

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Node_id
    Parent ID (room or folder ID)

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.PARAMETER Name
    Node name

.EXAMPLE
    PS C:\> Get-DracoonARNodeDeleted_NodeVersion -Type $type -Connection $connection -Node_id $node_id -Name $name

    ### Description:  
Retrieve all deleted versions of a node.

### Precondition:
User can access parent room and has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read recycle bin</span> permissions.

### Postcondition:
List of deleted versions of a node is returned.

### Further Information:
The node is identified by three parameters:
* parent ID (only room IDs are accepted as parent ID since only rooms may have a recycle bin.)
* name
* type (file, folder).

Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`expireAt:desc`  
Sort by `expireAt` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `expireAt` | Expiration date |
| `accessedAt` | Last access date |
| `size` | Node size |
| `classification` | Classification ID:<ul><li>1 - public</li><li>2 - internal</li><li>3 - confidential</li><li>4 - strictly confidential</li></ul> |
| `createdAt` | Creation date |
| `createdBy` | Creator first name, last name |
| `updatedAt` | Last modification date |
| `updatedBy` | Last modifier first name, last name |
| `deletedAt` | Deleted date |
| `deletedBy` | Deleter first name, last name |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Type,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Node_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Name
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Sort' = 'sort'
            'Type' = 'type'
            'Connection' = 'Connection'
            'Offset' = 'offset'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Limit' = 'limit'
            'Name' = 'name'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Sort','Type','Offset','Limit','Name') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'nodes/{node_id}/deleted_nodes/versions' -Replace '{node_id}',$Node_id
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}