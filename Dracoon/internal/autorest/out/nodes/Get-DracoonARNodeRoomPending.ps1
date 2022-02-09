function Get-DracoonARNodeRoomPending {
<#
.SYNOPSIS
    Request user-room assignments per group

.DESCRIPTION
    ### Description:  
Requests a list of user-room assignments by groups that have **NOT** been approved yet  
These can have the state:
* **WAITING**  
* **DENIED**  
* **ACCEPTED**  

**ACCEPTED** assignments are already removed from the list.

### Precondition:
None.

### Postcondition:
List of user-room assignments is returned.

### Further Information:
Room administrators **SHOULD** regularly request pending assingments to provide access to rooms for other users.

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`state:eq:WAITING`  
Filter assignments by state `WAITING`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `userId` | User ID filter | `eq` | User ID equals value. | `positive Integer` |
| `groupId` | Group ID filter | `eq` | Group ID equals value. | `positive Integer` |
| `roomId` | Room ID filter | `eq` | Room ID equals value. | `positive Integer` |
| `state` | Assignment state | `eq` | Assignment state equals value. | `WAITING or DENIED` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`userId:desc`  
Sort by `userId` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `userId` | User ID |
| `groupId` | Group ID |
| `roomId` | Room ID |
| `state` | State |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Filter
    Filter string

.PARAMETER Offset
    Range offset

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.PARAMETER Sort
    Sort string

.EXAMPLE
    PS C:\> Get-DracoonARNodeRoomPending -Connection $connection

    ### Description:  
Requests a list of user-room assignments by groups that have **NOT** been approved yet  
These can have the state:
* **WAITING**  
* **DENIED**  
* **ACCEPTED**  

**ACCEPTED** assignments are already removed from the list.

### Precondition:
None.

### Postcondition:
List of user-room assignments is returned.

### Further Information:
Room administrators **SHOULD** regularly request pending assingments to provide access to rooms for other users.

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`state:eq:WAITING`  
Filter assignments by state `WAITING`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `userId` | User ID filter | `eq` | User ID equals value. | `positive Integer` |
| `groupId` | Group ID filter | `eq` | Group ID equals value. | `positive Integer` |
| `roomId` | Room ID filter | `eq` | Room ID equals value. | `positive Integer` |
| `state` | Assignment state | `eq` | Assignment state equals value. | `WAITING or DENIED` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`userId:desc`  
Sort by `userId` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `userId` | User ID |
| `groupId` | Group ID |
| `roomId` | Room ID |
| `state` | State |

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
            'Limit' = 'limit'
            'Sort' = 'sort'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Offset','Limit','Sort') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/rooms/pending'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}