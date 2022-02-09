function Get-DracoonARNodeRoomGroup {
<#
.SYNOPSIS
    Request room granted group(s) or / and group(s) that can be granted

.DESCRIPTION
    ### Description:  
Retrieve a list of groups that are and / or can be granted to the room.

### Precondition:
Any permissions on target room.

### Postcondition:
List of groups is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`isGranted:eq:false|name:cn:searchString`  
Get all groups that are **NOT** granted to this room **AND** whose name is like `searchString`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `name` | Group name filter | `cn` | Group name contains value. | `search String` |
| `groupId` | Group ID filter | `eq` | Group ID equals value. | `positive Integer` |
| `isGranted` | Filter the groups that have (no) access to this room.<br>**This filter is only available for room administrators.**<br>**Other users can only look for groups in their rooms, so this filter is `true` and **CANNOT** be overridden.** | `eq` |  | <ul><li>`true`</li><li>`false`</li><li>`any`</li></ul>default: `true` |
| `permissionsManage` | Filter the groups that do (not) have `manage` permissions in this room. | `eq` |  | `true or false` |
| `effectivePerm` | Filter groups with DIRECT or DIRECT **AND** EFFECTIVE permissions<ul><li>`false`: DIRECT permissions</li><li>`true`: DIRECT **AND** EFFECTIVE permissions</li></ul>DIRECT means: e.g. room administrator grants `read` permissions to group of users **directly** on desired room.<br>EFFECTIVE means: e.g. group of users gets `read` permissions on desired room through **inheritance**. | `eq` |  | `true or false`<br>default: `false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`name:desc`  
Sort by `name` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `name` | Group name |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Sort
    Sort string

.PARAMETER Offset
    Range offset

.PARAMETER Room_id
    Room ID

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.PARAMETER Filter
    Filter string

.EXAMPLE
    PS C:\> Get-DracoonARNodeRoomGroup -Connection $connection -Room_id $room_id

    ### Description:  
Retrieve a list of groups that are and / or can be granted to the room.

### Precondition:
Any permissions on target room.

### Postcondition:
List of groups is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`isGranted:eq:false|name:cn:searchString`  
Get all groups that are **NOT** granted to this room **AND** whose name is like `searchString`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `name` | Group name filter | `cn` | Group name contains value. | `search String` |
| `groupId` | Group ID filter | `eq` | Group ID equals value. | `positive Integer` |
| `isGranted` | Filter the groups that have (no) access to this room.<br>**This filter is only available for room administrators.**<br>**Other users can only look for groups in their rooms, so this filter is `true` and **CANNOT** be overridden.** | `eq` |  | <ul><li>`true`</li><li>`false`</li><li>`any`</li></ul>default: `true` |
| `permissionsManage` | Filter the groups that do (not) have `manage` permissions in this room. | `eq` |  | `true or false` |
| `effectivePerm` | Filter groups with DIRECT or DIRECT **AND** EFFECTIVE permissions<ul><li>`false`: DIRECT permissions</li><li>`true`: DIRECT **AND** EFFECTIVE permissions</li></ul>DIRECT means: e.g. room administrator grants `read` permissions to group of users **directly** on desired room.<br>EFFECTIVE means: e.g. group of users gets `read` permissions on desired room through **inheritance**. | `eq` |  | `true or false`<br>default: `false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`name:desc`  
Sort by `name` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `name` | Group name |

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
        $Sort,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Room_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
            'Sort' = 'sort'
            'Offset' = 'offset'
            'Limit' = 'limit'
            'Filter' = 'filter'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Sort','Offset','Limit','Filter') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/rooms/{room_id}/groups' -Replace '{room_id}',$Room_id
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}