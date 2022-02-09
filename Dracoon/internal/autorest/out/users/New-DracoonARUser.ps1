function New-DracoonARUser {
<#
.SYNOPSIS
    Update user's metadata

.DESCRIPTION
    ### Description:  
Update user's metadata.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
User's metadata is updated.

### Further Information:
* If a user should **NOT** expire, leave `expireAt` empty.
* All input fields are limited to **150** characters
* **All** characters are allowed.

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

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER User_id
    User ID

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARUser -User_id $user_id -Connection $connection

    ### Description:  
Update user's metadata.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change users</span> required.

### Postcondition:
User's metadata is updated.

### Further Information:
* If a user should **NOT** expire, leave `expireAt` empty.
* All input fields are limited to **150** characters
* **All** characters are allowed.

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
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $User_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'users/{user_id}' -Replace '{user_id}',$User_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}