function Set-DracoonARProvisioningCustomer {
<#
.SYNOPSIS
    Create customer

.DESCRIPTION
    ### Description:
Create a new customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  

### Postcondition:
A new customer is created.

### Further Information:
If no company name is set, first letter of the first name separated by dot following by last name of the first administrator is used (e.g. `J.Doe`).  
Max quota has to be at least `1 MB` (= `1.048.576 B`).

If `basic` authentication is enabled, the first administrator will get `basic` authentication by default.  
To create a first administrator without `basic` authentication it **MUST** be disabled explicitly.  

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

### Authentication Method Options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method | Option Key | Option Value |
| :--- | :--- | :--- |
| `basic` / `sql` | `username` | Unique user identifier |
| `active_directory` | `ad_config_id` (optional) | Active Directory configuration ID |
|  | `username` | Active Directory username according to authentication setting `userFilter` |
| `radius` | `username` | RADIUS username |
| `openid` | `openid_config_id` (optional) | OpenID Connect configuration ID |
|  | `username` | OpenID Connect username according to authentication setting `mappingClaim` |

</details>


.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARProvisioningCustomer -Connection $connection

    ### Description:
Create a new customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.  

### Postcondition:
A new customer is created.

### Further Information:
If no company name is set, first letter of the first name separated by dot following by last name of the first administrator is used (e.g. `J.Doe`).  
Max quota has to be at least `1 MB` (= `1.048.576 B`).

If `basic` authentication is enabled, the first administrator will get `basic` authentication by default.  
To create a first administrator without `basic` authentication it **MUST** be disabled explicitly.  

Forbidden characters in passwords: [`&`, `'`, `<`, `>`]

### Authentication Method Options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method | Option Key | Option Value |
| :--- | :--- | :--- |
| `basic` / `sql` | `username` | Unique user identifier |
| `active_directory` | `ad_config_id` (optional) | Active Directory configuration ID |
|  | `username` | Active Directory username according to authentication setting `userFilter` |
| `radius` | `username` | RADIUS username |
| `openid` | `openid_config_id` (optional) | OpenID Connect configuration ID |
|  | `username` | OpenID Connect username according to authentication setting `mappingClaim` |

</details>


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsServiceToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsServiceToken' = 'X-Sds-Service-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'provisioning/customers'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}