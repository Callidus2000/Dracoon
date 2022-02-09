function Get-DracoonARProvisioningCustomerCustomerattribute {
<#
.SYNOPSIS
    Request customer attributes

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:  
Retrieve a list of customer attributes.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read all customers</span> required.

### Postcondition:
List of attributes is returned.

### Further Information:

### Filtering:
Filters are case insensitive.  
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`key:cn:searchString_1|value:cn:searchString_2`  
Filter by attribute key contains `searchString_1` **AND** attribute value contains `searchString_2`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `key` | Customer attribute key filter | `cn, eq, sw` | Attribute key contains / equals / starts with value. | `search String` |
| `value` | Customer attribute value filter | `cn, eq, sw` | Attribute value contains / equals / starts with value. | `search String` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`key:asc|value:desc`  
Sort by `key` ascending **AND** by `value` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `key` | Customer attribute key |
| `value` | Customer attribute value |

</details>

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

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Customer_id
    Customer ID

.EXAMPLE
    PS C:\> Get-DracoonARProvisioningCustomerCustomerattribute -Connection $connection -Customer_id $customer_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:  
Retrieve a list of customer attributes.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read all customers</span> required.

### Postcondition:
List of attributes is returned.

### Further Information:

### Filtering:
Filters are case insensitive.  
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`key:cn:searchString_1|value:cn:searchString_2`  
Filter by attribute key contains `searchString_1` **AND** attribute value contains `searchString_2`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `key` | Customer attribute key filter | `cn, eq, sw` | Attribute key contains / equals / starts with value. | `search String` |
| `value` | Customer attribute value filter | `cn, eq, sw` | Attribute value contains / equals / starts with value. | `search String` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`key:asc|value:desc`  
Sort by `key` ascending **AND** by `value` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `key` | Customer attribute key |
| `value` | Customer attribute value |

</details>

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
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsServiceToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Customer_id
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'Filter' = 'filter'
            'Offset' = 'offset'
            'Limit' = 'limit'
            'Sort' = 'sort'
            'XSdsServiceToken' = 'X-Sds-Service-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Offset','Limit','Sort') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/customers/{customer_id}/customerAttributes' -Replace '{customer_id}',$Customer_id
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}