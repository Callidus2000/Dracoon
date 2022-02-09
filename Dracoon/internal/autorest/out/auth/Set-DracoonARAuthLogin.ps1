function Set-DracoonARAuthLogin {
<#
.SYNOPSIS
    Authenticate user (Login)

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.13.0</h3>

### Description:
Authenticates user and provides an authentication token (`X-Sds-Auth-Token`) that is required for the most operations.

### Precondition:
Existing user that is **NOT** locked.

### Postcondition:
User is logged in.

### Further Information:
The provided token is valid for **two hours**, every usage resets this period to two full hours again.  
Logging off invalidates the token.  

### Available authentication methods:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method (`authType`) | Description |
| :--- | :--- |
| `basic` | Log in with credentials stored in the database <br>Formerly known as `sql`.|
| `active_directory` | Log in with Active Directory credentials |
| `radius` | Log in with RADIUS username, PIN and token password.<br>Token (request parameter) may be set, otherwise this parameter is ignored. If token is set, password is optional. |
| `openid` | Please use `POST /auth/openid/login` API to login with OpenID Connect identity |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARAuthLogin -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128679; Deprecated since v4.13.0</h3>

### Description:
Authenticates user and provides an authentication token (`X-Sds-Auth-Token`) that is required for the most operations.

### Precondition:
Existing user that is **NOT** locked.

### Postcondition:
User is logged in.

### Further Information:
The provided token is valid for **two hours**, every usage resets this period to two full hours again.  
Logging off invalidates the token.  

### Available authentication methods:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method (`authType`) | Description |
| :--- | :--- |
| `basic` | Log in with credentials stored in the database <br>Formerly known as `sql`.|
| `active_directory` | Log in with Active Directory credentials |
| `radius` | Log in with RADIUS username, PIN and token password.<br>Token (request parameter) may be set, otherwise this parameter is ignored. If token is set, password is optional. |
| `openid` | Please use `POST /auth/openid/login` API to login with OpenID Connect identity |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'auth/login'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}