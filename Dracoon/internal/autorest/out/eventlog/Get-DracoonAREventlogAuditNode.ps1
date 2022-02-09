function Get-DracoonAREventlogAuditNode {
<#
.SYNOPSIS
    Request node assigned users with permissions

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.3.0</h3>

### Description: 
Retrieve a list of all nodes of type room, and the room assignment users with permissions.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read audit log</span> required.

### Postcondition:
List of rooms and their assigned users is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Except for `userName`, `userFirstName` and  `userLastName` - these are connected via logical disjunction (**OR**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`userName:cn:searchString_1|userFirstName:cn:searchString_2|nodeId:eq:2`  
Filter by user login containing `searchString_1` **OR** first name containing `searchString_2` **AND** node ID equals `2`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `nodeId` | Node ID filter | `eq` | Node ID equals value. | `positive Integer` |
| `nodeName` | Node name filter | `cn, eq` | Node name contains / equals value. | `search String` |
| `nodeParentId` | Node parent ID filter | `eq` | Parent ID equals value. | `positive Integer`<br>Parent ID `0` is the root node. |
| `userId` | User ID filter | `eq` | User ID equals value. | `positive Integer` |
| `userName` | Username (login) filter | `cn, eq` | Username contains / equals value. | `search String` |
| `userFirstName` | User first name filter | `cn, eq` | User first name contains / equals value. | `search String` |
| `userLastName` | User last name filter | `cn, eq` | User last name contains / equals value. | `search String` |
| `permissionsManage` | Filter the users that do (not) have `manage` permissions in this room | `eq` |  | `true or false` |
| `nodeIsEncrypted` | Encrypted node filter | `eq` |  | `true or false` |
| `nodeHasActivitiesLog` | Activities log filter | `eq` |  | `true or false` |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`nodeHasRecycleBin`</del> | Recycle bin filter<br>**Filter has no effect!** | `eq` |  | `true or false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`nodeName:asc`  
Sort by `nodeName` ascending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `nodeId` | Node ID |
| `nodeName` | Node name |
| `nodeParentId` | Node parent ID |
| `nodeSize` | Node size |
| `nodeQuota` | Node quota |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Filter
    Filter string

.PARAMETER Offset
    Range offset

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.PARAMETER Sort
    Sort string

.EXAMPLE
    PS C:\> Get-DracoonAREventlogAuditNode -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.3.0</h3>

### Description: 
Retrieve a list of all nodes of type room, and the room assignment users with permissions.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read audit log</span> required.

### Postcondition:
List of rooms and their assigned users is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Except for `userName`, `userFirstName` and  `userLastName` - these are connected via logical disjunction (**OR**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`userName:cn:searchString_1|userFirstName:cn:searchString_2|nodeId:eq:2`  
Filter by user login containing `searchString_1` **OR** first name containing `searchString_2` **AND** node ID equals `2`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `nodeId` | Node ID filter | `eq` | Node ID equals value. | `positive Integer` |
| `nodeName` | Node name filter | `cn, eq` | Node name contains / equals value. | `search String` |
| `nodeParentId` | Node parent ID filter | `eq` | Parent ID equals value. | `positive Integer`<br>Parent ID `0` is the root node. |
| `userId` | User ID filter | `eq` | User ID equals value. | `positive Integer` |
| `userName` | Username (login) filter | `cn, eq` | Username contains / equals value. | `search String` |
| `userFirstName` | User first name filter | `cn, eq` | User first name contains / equals value. | `search String` |
| `userLastName` | User last name filter | `cn, eq` | User last name contains / equals value. | `search String` |
| `permissionsManage` | Filter the users that do (not) have `manage` permissions in this room | `eq` |  | `true or false` |
| `nodeIsEncrypted` | Encrypted node filter | `eq` |  | `true or false` |
| `nodeHasActivitiesLog` | Activities log filter | `eq` |  | `true or false` |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`nodeHasRecycleBin`</del> | Recycle bin filter<br>**Filter has no effect!** | `eq` |  | `true or false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`nodeName:asc`  
Sort by `nodeName` ascending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `nodeId` | Node ID |
| `nodeName` | Node name |
| `nodeParentId` | Node parent ID |
| `nodeSize` | Node size |
| `nodeQuota` | Node quota |

</details>

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

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
            'Filter' = 'filter'
            'Offset' = 'offset'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Limit' = 'limit'
            'Sort' = 'sort'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Offset','Limit','Sort') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'eventlog/audits/nodes'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}