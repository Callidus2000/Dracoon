function Get-DracoonARConfigInfoDefault {
<#
.SYNOPSIS
    Request default values

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.6.0</h3>

### Description:  
Returns a list of configurable system default values.

### Precondition:
Authenticated user.

### Postcondition:
List of configurable default settings is returned.

### Further Information:
None.

### Configurable default values:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `languageDefault` | Defines which language should be default. | `ISO 639-1 code` |
| `downloadShareDefaultExpirationPeriod` | Default expiration period for Download Shares in _days_. | `Integer between 0 and 9999` |
| `uploadShareDefaultExpirationPeriod` | Default expiration period for Upload Shares in _days_. | `Integer between 0 and 9999` |
| `fileDefaultExpirationPeriod` | Default expiration period for all uploaded files in _days_. | `Integer between 0 and 9999` |
| `nonmemberViewerDefault` | Defines if new users get the role _Non Member Viewer_ by default | `true or false` |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARConfigInfoDefault -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.6.0</h3>

### Description:  
Returns a list of configurable system default values.

### Precondition:
Authenticated user.

### Postcondition:
List of configurable default settings is returned.

### Further Information:
None.

### Configurable default values:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `languageDefault` | Defines which language should be default. | `ISO 639-1 code` |
| `downloadShareDefaultExpirationPeriod` | Default expiration period for Download Shares in _days_. | `Integer between 0 and 9999` |
| `uploadShareDefaultExpirationPeriod` | Default expiration period for Upload Shares in _days_. | `Integer between 0 and 9999` |
| `fileDefaultExpirationPeriod` | Default expiration period for all uploaded files in _days_. | `Integer between 0 and 9999` |
| `nonmemberViewerDefault` | Defines if new users get the role _Non Member Viewer_ by default | `true or false` |

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
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'config/info/defaults'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}