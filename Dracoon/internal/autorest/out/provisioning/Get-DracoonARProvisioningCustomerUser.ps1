function Get-DracoonARProvisioningCustomerUser {
<#
.SYNOPSIS
    Request list of customer users

.DESCRIPTION
    ### Description:  
Receive a list of users associated with a certain customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
List of customer users is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Except for `login`, `firstName` and  `lastName` - these are connected via logical disjunction (**OR**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`login:cn:searchString_1|firstName:cn:searchString_2|lockStatus:eq:2`  
Filter users by login contains `searchString_1` **OR** firstName contains `searchString_2` **AND** those who are **NOT** locked.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `email` | Email filter | `eq`, `cn` | Email contains value. | `search String` |
| `userName` | User name filter | `eq`, `cn` | UserName contains value. | `search String` |
| `firstName` | User first name filter | `cn` | User first name contains value. | `search String` |
| `lastName` | User last name filter | `cn` | User last name contains value. | `search String` |
| `isLocked` | User lock status filter | `eq` |  | `true or false` |
| `effectiveRoles` | Filter users with DIRECT or DIRECT **AND** EFFECTIVE roles<ul><li>`false`: DIRECT roles</li><li>`true`: DIRECT **AND** EFFECTIVE roles</li></ul>DIRECT means: e.g. user gets role **directly** granted from someone with _grant permission_ right.<br>EFFECTIVE means: e.g. user gets role through **group membership**. | `eq` |  | `true or false`<br>default: `false` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `phone` | Phone filter | `eq` | Phone equals value. | `search String` |
| `isEncryptionEnabled` | Encryption status filter<ul><li>client-side encryption</li><li>private key possession</li></ul> | `eq` |  | `true or false` |
| `hasRole` | (**`NEW`**) User role filter<br>Depends on **effectiveRoles**.<br>For more information about roles check **`GET /roles`** API | `eq` | User role equals value. | <ul><li>`CONFIG_MANAGER` - Manages global configuration</li><li>`USER_MANAGER` - Manages users</li><li>`GROUP_MANAGER` - Manages user groups</li><li>`ROOM_MANAGER` - Manages top level rooms</li><li>`LOG_AUDITOR` - Reads audit logs</li><li>`NONMEMBER_VIEWER` - Views users and groups when having room _"manage"_ permission</li></ul> |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`lockStatus`</del> | User lock status filter | `eq` | User lock status equals value. | <ul><li>`0` - Locked</li><li>`1` - Web access allowed</li><li>`2` - Web and mobile access allowed</li></ul> |
| <del>`login`</del> |  User login filter | `cn` | User login contains value. | `search String` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`firstName:asc|lastLoginSuccessAt:desc`  
Sort by `firstName` ascending **AND** by `lastLoginSuccessAt` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `userName` | User name |
| `email` | User email |
| `firstName` | User first name |
| `lastName` | User last name |
| `isLocked` | User lock status |
| `lastLoginSuccessAt` | Last successful login date |
| `expireAt` | Expiration date |
| `createdAt` | Creation date |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`gender`</del> | Gender |
| <del>`lockStatus`</del> | User lock status |
| <del>`login`</del> | User login |

</details>

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

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Customer_id
    Customer ID

.EXAMPLE
    PS C:\> Get-DracoonARProvisioningCustomerUser -Connection $connection -Customer_id $customer_id

    ### Description:  
Receive a list of users associated with a certain customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
List of customer users is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Except for `login`, `firstName` and  `lastName` - these are connected via logical disjunction (**OR**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`login:cn:searchString_1|firstName:cn:searchString_2|lockStatus:eq:2`  
Filter users by login contains `searchString_1` **OR** firstName contains `searchString_2` **AND** those who are **NOT** locked.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `email` | Email filter | `eq`, `cn` | Email contains value. | `search String` |
| `userName` | User name filter | `eq`, `cn` | UserName contains value. | `search String` |
| `firstName` | User first name filter | `cn` | User first name contains value. | `search String` |
| `lastName` | User last name filter | `cn` | User last name contains value. | `search String` |
| `isLocked` | User lock status filter | `eq` |  | `true or false` |
| `effectiveRoles` | Filter users with DIRECT or DIRECT **AND** EFFECTIVE roles<ul><li>`false`: DIRECT roles</li><li>`true`: DIRECT **AND** EFFECTIVE roles</li></ul>DIRECT means: e.g. user gets role **directly** granted from someone with _grant permission_ right.<br>EFFECTIVE means: e.g. user gets role through **group membership**. | `eq` |  | `true or false`<br>default: `false` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `phone` | Phone filter | `eq` | Phone equals value. | `search String` |
| `isEncryptionEnabled` | Encryption status filter<ul><li>client-side encryption</li><li>private key possession</li></ul> | `eq` |  | `true or false` |
| `hasRole` | (**`NEW`**) User role filter<br>Depends on **effectiveRoles**.<br>For more information about roles check **`GET /roles`** API | `eq` | User role equals value. | <ul><li>`CONFIG_MANAGER` - Manages global configuration</li><li>`USER_MANAGER` - Manages users</li><li>`GROUP_MANAGER` - Manages user groups</li><li>`ROOM_MANAGER` - Manages top level rooms</li><li>`LOG_AUDITOR` - Reads audit logs</li><li>`NONMEMBER_VIEWER` - Views users and groups when having room _"manage"_ permission</li></ul> |

</details>

### Deprecated filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| <del>`lockStatus`</del> | User lock status filter | `eq` | User lock status equals value. | <ul><li>`0` - Locked</li><li>`1` - Web access allowed</li><li>`2` - Web and mobile access allowed</li></ul> |
| <del>`login`</del> |  User login filter | `cn` | User login contains value. | `search String` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`firstName:asc|lastLoginSuccessAt:desc`  
Sort by `firstName` ascending **AND** by `lastLoginSuccessAt` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `userName` | User name |
| `email` | User email |
| `firstName` | User first name |
| `lastName` | User last name |
| `isLocked` | User lock status |
| `lastLoginSuccessAt` | Last successful login date |
| `expireAt` | Expiration date |
| `createdAt` | Creation date |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`gender`</del> | Gender |
| <del>`lockStatus`</del> | User lock status |
| <del>`login`</del> | User login |

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
        $XSdsDateFormat,

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
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Limit' = 'limit'
            'Sort' = 'sort'
            'XSdsServiceToken' = 'X-Sds-Service-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Offset','Limit','Sort') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/customers/{customer_id}/users' -Replace '{customer_id}',$Customer_id
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}