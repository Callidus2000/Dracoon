function Get-DracoonARSystemConfigOauthClient {
<#
.SYNOPSIS
    Request list of OAuth clients

.DESCRIPTION
    ### Description:  
Retrieve a list of configured OAuth clients.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
List of OAuth clients is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`isStandard:eq:true`  
Get standard OAuth clients.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `isStandard` | Standard client filter | `eq` |  | `true or false` |
| `isExternal` | External client filter | `eq` |  | `true or false` |
| `isEnabled` | Enabled/disabled clients filter | `eq` |  | `true or false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`clientName:desc`  
Sort by `clientName` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `clientName` | Client name |
| `isStandard` | Is a standard client |
| `isExternal` | Is a external client |
| `isEnabled` | Is a enabled client |

</details>

.PARAMETER Sort
    Sort string

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Client_id
    OAuth client ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Filter
    Filter string

.EXAMPLE
    PS C:\> Get-DracoonARSystemConfigOauthClient -Client_id $client_id

    ### Description:  
Retrieve the configuration of an OAuth client.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
OAuth client is returned.

### Further Information:
None.

.EXAMPLE
    PS C:\> Get-DracoonARSystemConfigOauthClient -Connection $connection

    ### Description:  
Retrieve a list of configured OAuth clients.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
List of OAuth clients is returned.

### Further Information:

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`isStandard:eq:true`  
Get standard OAuth clients.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `isStandard` | Standard client filter | `eq` |  | `true or false` |
| `isExternal` | External client filter | `eq` |  | `true or false` |
| `isEnabled` | Enabled/disabled clients filter | `eq` |  | `true or false` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`clientName:desc`  
Sort by `clientName` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `clientName` | Client name |
| `isStandard` | Is a standard client |
| `isExternal` | Is a external client |
| `isEnabled` | Is a enabled client |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestOAuthClient')]
        [string]
        $Client_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'requestOAuthClient')]
        [string]
        $XSdsAuthToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter
    )
    process {
        $__mapping = @{
            'Sort' = 'sort'
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Filter' = 'filter'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Sort','Filter') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'system/config/oauth/clients'
        if ($Client_id) { $__path += "/$Client_id" }
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}