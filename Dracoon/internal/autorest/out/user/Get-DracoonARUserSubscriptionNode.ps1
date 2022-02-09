function Get-DracoonARUserSubscriptionNode {
<#
.SYNOPSIS
    List node subscriptions

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.20.0</h3>

### Description:  
Retrieve a list of subscribed nodes for current user. 

### Precondition:
Authenticated user.

### Postcondition:
List of subscribed nodes is returned.

### Further Information:
None.

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`authParentId:eq:#`  
Get nodes where `authParentId` equals `#`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| **`nodeId`** | Node ID filter | `eq` | Node ID equals value. | `long value` |
| **`authParentId`** | Auth parent ID filter | `eq` | Auth parent ID equals value. | `long value` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`nodeId:desc`  
Sort by `nodeId` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| **`nodeId`** | Node ID |
| **`authParentId`** | Auth parent ID |

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
    PS C:\> Get-DracoonARUserSubscriptionNode -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.20.0</h3>

### Description:  
Retrieve a list of subscribed nodes for current user. 

### Precondition:
Authenticated user.

### Postcondition:
List of subscribed nodes is returned.

### Further Information:
None.

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`authParentId:eq:#`  
Get nodes where `authParentId` equals `#`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| **`nodeId`** | Node ID filter | `eq` | Node ID equals value. | `long value` |
| **`authParentId`** | Auth parent ID filter | `eq` | Auth parent ID equals value. | `long value` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`nodeId:desc`  
Sort by `nodeId` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| **`nodeId`** | Node ID |
| **`authParentId`** | Auth parent ID |

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
        $__path = 'user/subscriptions/nodes'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}