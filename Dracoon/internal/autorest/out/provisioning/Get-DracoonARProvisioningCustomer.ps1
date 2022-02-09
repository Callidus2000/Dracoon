function Get-DracoonARProvisioningCustomer {
<#
.SYNOPSIS
    Request list of customers

.DESCRIPTION
    ### Description:  
Receive a list of customers.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
List of customers is returned.

### Further Information:
This list returns a maximum of **1000** entries.  

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`trialDaysLeft:le:10|userMax:le:100`  
Get all customers with `10` trial days left **AND** user maximum **<=** `100`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `id` | Customer ID filter | `eq` | Customer ID equals value. | `positive Integer` |
| `companyName` | Company name filter | `cn` | Company name contains value. | `search String` |
| `customerContractType` | Customer contract type filter | `eq` | Customer contract type equals value. | <ul><li>`demo`</li><li>`free`</li><li>`pay`</li></ul> |
| `trialDaysLeft` | Left trial days filter | `ge, le` | Left trial days are greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `trialDaysLeft:ge:5`&#124;`trialDaysLeft:le:10` |
| `providerCustomerId` | Provider Customer ID filter | `cn, eq` | Provider Customer ID contains / equals value. | `search String` |
| `quotaMax` | Maximum quota filter | `ge, le` | Maximum quota is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `quotaMax:ge:1024`&#124;`quotaMax:le:1073741824` | `positive Integer` |
| `quotaUsed` | Used quota filter | `ge, le` | Used quota is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `quotaUsed:ge:1024`&#124;`quotaUsed:le:1073741824` | `positive Integer` |
| `userMax` | User maximum filter | `ge, le` | User maxiumum is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `userMax:ge:10`&#124;`userMax:le:100` | `positive Integer` |
| `userUsed` | Number of registered users filter | `ge, le` | Number of registered users is is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `userUsed:ge:10`&#124;`userUsed:le:100` | `positive Integer` |
| `isLocked` | Lock status filter | `eq` |  | `true or false` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `updatedAt` | Last modification date filter | `ge, le` | Last modification date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `updatedAt:ge:2016-12-31`&#124;`updatedAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `lastLoginAt` | Last login date filter | `ge, le` | Last login date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `lastLoginAt:ge:2016-12-31`&#124;`lastLoginAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `userLogin` | User login filter | `eq` | User login name equals value.<br>Search user all logins e.g. `basic`, `active_directory`, `radius`. | `search String` |
| `attributeKey` | Customer attribute key filter | `eq`, `nex` | Customer attribute key equals value / Customer attribute does **NOT** exist at customer | `search String` |
| `attributeValue` | Customer attribute value filter | `eq` | Customer attribute value equals value. | `search String` |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`activationCode`</del> | Activation code filter | `cn, eq` | Activation code contains / equals value. | `search String` |
| <del>`lockStatus`</del> | Lock status filter | `eq` |  | <ul><li>`0` - unlocked</li><li>`1` - locked</li></ul> |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`companyName:desc`  
Sort by `companyName` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `companyName` | Company name |
| `customerContractType` | Customer contract type |
| `trialDaysLeft` | Number of remaining trial days (demo customers) |
| `providerCustomerId` | Provider Customer ID |
| `quotaMax` | Maximum quota |
| `quotaUsed` | Currently used quota |
| `userMax` | Maximum user number |
| `userUsed` | Number of registered users |
| `isLocked` | Lock status of customer |
| `createdAt` | Creation date |
| `updatedAt` | Last modification date |
| `lastLoginAt` | Last login date of any user of this customer |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`lockStatus`</del> | Lock status of customer |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Filter
    Filter string

.PARAMETER Include_attributes
    Include custom customer attributes.

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

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Customer_id
    Customer ID

.EXAMPLE
    PS C:\> Get-DracoonARProvisioningCustomer -Customer_id $customer_id

    ### Description:  
Receive details of a selected customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
Customer details are returned.

### Further Information:
None.

.EXAMPLE
    PS C:\> Get-DracoonARProvisioningCustomer -Connection $connection

    ### Description:  
Receive a list of customers.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
List of customers is returned.

### Further Information:
This list returns a maximum of **1000** entries.  

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`trialDaysLeft:le:10|userMax:le:100`  
Get all customers with `10` trial days left **AND** user maximum **<=** `100`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `id` | Customer ID filter | `eq` | Customer ID equals value. | `positive Integer` |
| `companyName` | Company name filter | `cn` | Company name contains value. | `search String` |
| `customerContractType` | Customer contract type filter | `eq` | Customer contract type equals value. | <ul><li>`demo`</li><li>`free`</li><li>`pay`</li></ul> |
| `trialDaysLeft` | Left trial days filter | `ge, le` | Left trial days are greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `trialDaysLeft:ge:5`&#124;`trialDaysLeft:le:10` |
| `providerCustomerId` | Provider Customer ID filter | `cn, eq` | Provider Customer ID contains / equals value. | `search String` |
| `quotaMax` | Maximum quota filter | `ge, le` | Maximum quota is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `quotaMax:ge:1024`&#124;`quotaMax:le:1073741824` | `positive Integer` |
| `quotaUsed` | Used quota filter | `ge, le` | Used quota is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `quotaUsed:ge:1024`&#124;`quotaUsed:le:1073741824` | `positive Integer` |
| `userMax` | User maximum filter | `ge, le` | User maxiumum is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `userMax:ge:10`&#124;`userMax:le:100` | `positive Integer` |
| `userUsed` | Number of registered users filter | `ge, le` | Number of registered users is is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `userUsed:ge:10`&#124;`userUsed:le:100` | `positive Integer` |
| `isLocked` | Lock status filter | `eq` |  | `true or false` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `updatedAt` | Last modification date filter | `ge, le` | Last modification date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `updatedAt:ge:2016-12-31`&#124;`updatedAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `lastLoginAt` | Last login date filter | `ge, le` | Last login date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `lastLoginAt:ge:2016-12-31`&#124;`lastLoginAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `userLogin` | User login filter | `eq` | User login name equals value.<br>Search user all logins e.g. `basic`, `active_directory`, `radius`. | `search String` |
| `attributeKey` | Customer attribute key filter | `eq`, `nex` | Customer attribute key equals value / Customer attribute does **NOT** exist at customer | `search String` |
| `attributeValue` | Customer attribute value filter | `eq` | Customer attribute value equals value. | `search String` |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`activationCode`</del> | Activation code filter | `cn, eq` | Activation code contains / equals value. | `search String` |
| <del>`lockStatus`</del> | Lock status filter | `eq` |  | <ul><li>`0` - unlocked</li><li>`1` - locked</li></ul> |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`companyName:desc`  
Sort by `companyName` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `companyName` | Company name |
| `customerContractType` | Customer contract type |
| `trialDaysLeft` | Number of remaining trial days (demo customers) |
| `providerCustomerId` | Provider Customer ID |
| `quotaMax` | Maximum quota |
| `quotaUsed` | Currently used quota |
| `userMax` | Maximum user number |
| `userUsed` | Number of registered users |
| `isLocked` | Lock status of customer |
| `createdAt` | Creation date |
| `updatedAt` | Last modification date |
| `lastLoginAt` | Last login date of any user of this customer |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`lockStatus`</del> | Lock status of customer |

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
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestCustomer')]
        [boolean]
        $Include_attributes,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestCustomer')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestCustomer')]
        [string]
        $XSdsServiceToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestCustomer')]
        [string]
        $Customer_id
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'Filter' = 'filter'
            'Include_attributes' = 'include_attributes'
            'Offset' = 'offset'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Limit' = 'limit'
            'Sort' = 'sort'
            'XSdsServiceToken' = 'X-Sds-Service-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Include_attributes','Offset','Limit','Sort') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/customers'
        if ($Customer_id) { $__path += "/$Customer_id" }
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}