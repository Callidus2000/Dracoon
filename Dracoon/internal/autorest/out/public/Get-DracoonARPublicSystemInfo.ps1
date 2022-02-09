function Get-DracoonARPublicSystemInfo {
<#
.SYNOPSIS
    Request system information

.DESCRIPTION
    ### Description:  
Provides information about system.

### Precondition:
None.

### Postcondition:
System information is returned.

### Further Information:
Authentication methods are sorted by **priority** attribute.  
Smaller values have higher priority.  
Authentication method with highest priority is considered as default.

### System information:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `languageDefault` | Defines which language should be default. | `ISO 639-1 code` |
| `hideLoginInputFields` | Defines if login fields should be hidden. | `true or false` |
| `s3Hosts` | List of available S3 hosts. | `String array` |
| `s3EnforceDirectUpload` | Determines whether S3 direct upload is enforced or not. | `true or false` |
| `useS3Storage` | Determines whether S3 Storage enabled and used. | `true or false` |

</details>

### Authentication methods:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method | Description |
| :--- | :--- |
| `basic` | **Basic** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their credentials stored in the database.<br>Formerly known as `sql`. |
| `active_directory` | **Active Directory** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their Active Directory credentials. |
| `radius` | **RADIUS** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their RADIUS username, their PIN and a token password. |
| `openid` | **OpenID Connect** authentication globally allowed.This option **MUST** be activated to allow users to log in with their OpenID Connect identity. |
| `hideLoginInputFields` | Determines whether input fields for login should be enabled | `true or false` |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Is_enabled
    Show only enabled authentication methods

.EXAMPLE
    PS C:\> Get-DracoonARPublicSystemInfo -Connection $connection

    ### Description:  
Provides information about system.

### Precondition:
None.

### Postcondition:
System information is returned.

### Further Information:
Authentication methods are sorted by **priority** attribute.  
Smaller values have higher priority.  
Authentication method with highest priority is considered as default.

### System information:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `languageDefault` | Defines which language should be default. | `ISO 639-1 code` |
| `hideLoginInputFields` | Defines if login fields should be hidden. | `true or false` |
| `s3Hosts` | List of available S3 hosts. | `String array` |
| `s3EnforceDirectUpload` | Determines whether S3 direct upload is enforced or not. | `true or false` |
| `useS3Storage` | Determines whether S3 Storage enabled and used. | `true or false` |

</details>

### Authentication methods:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Authentication Method | Description |
| :--- | :--- |
| `basic` | **Basic** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their credentials stored in the database.<br>Formerly known as `sql`. |
| `active_directory` | **Active Directory** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their Active Directory credentials. |
| `radius` | **RADIUS** authentication globally allowed.<br>This option **MUST** be activated to allow users to log in with their RADIUS username, their PIN and a token password. |
| `openid` | **OpenID Connect** authentication globally allowed.This option **MUST** be activated to allow users to log in with their OpenID Connect identity. |
| `hideLoginInputFields` | Determines whether input fields for login should be enabled | `true or false` |

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
        [boolean]
        $Is_enabled
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'Is_enabled' = 'is_enabled'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Is_enabled') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'public/system/info'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}