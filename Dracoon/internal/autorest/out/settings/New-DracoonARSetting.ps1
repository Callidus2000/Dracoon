function New-DracoonARSetting {
<#
.SYNOPSIS
    Set customer settings

.DESCRIPTION
    ### Description:  
Set customer related settings.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> required.

### Postcondition:
Provided settings are updated.

### Further Information:
None.

### Configurable customer settings
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `homeRoomParentName` | Name of the container in which all user's home rooms are located.<br>`null` if `homeRoomsActive` is `false`. | `String` |
| `homeRoomQuota` | Refers to the quota of each single user's home room.<br>`0` represents no quota.<br>`null` if `homeRoomsActive` is `false`. | `positive Long` |
| `homeRoomsActive` | If set to `true`, every user with an Active Directory account gets a personal homeroom.<br>Once activated, this **CANNOT** be deactivated. | `true or false` |

</details>

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> New-DracoonARSetting -Connection $connection

    ### Description:  
Set customer related settings.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> required.

### Postcondition:
Provided settings are updated.

### Further Information:
None.

### Configurable customer settings
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `homeRoomParentName` | Name of the container in which all user's home rooms are located.<br>`null` if `homeRoomsActive` is `false`. | `String` |
| `homeRoomQuota` | Refers to the quota of each single user's home room.<br>`0` represents no quota.<br>`null` if `homeRoomsActive` is `false`. | `positive Long` |
| `homeRoomsActive` | If set to `true`, every user with an Active Directory account gets a personal homeroom.<br>Once activated, this **CANNOT** be deactivated. | `true or false` |

</details>

### Node naming convention:
* Node (room, folder, file) names are limited to **150** characters.
* Illegal names:  
`'CON', 'PRN', 'AUX', 'NUL', 'COM1', 'COM2', 'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8', 'LPT9', (and any of those with an extension)`
* Illegal characters in names:  
`'\\', '<','>', ':', '\"', '|', '?', '*', '/', leading '-', trailing '.' `


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
        $__path = 'settings'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}