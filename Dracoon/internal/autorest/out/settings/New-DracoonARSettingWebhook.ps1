function New-DracoonARSettingWebhook {
<#
.SYNOPSIS
    Update webhook

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Update an existing webhook for the customer scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change config</span> required.

### Postcondition:
Webhook is updated.

### Further Information:
URL must begin with the `HTTPS` scheme.
Webhook names are limited to 150 characters.
Webhook event types can not be changed from Customer Admin Webhook types to Node Webhook types and vice versa  

### Available event types:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Name | Description | Scope |
| :--- | :--- | :--- |
| **`user.created`** | Triggered when a new user is created | Customer Admin Webhook |
| **`user.deleted`** | Triggered when a user is deleted | Customer Admin Webhook |
| **`user.locked`** | Triggered when a user gets locked | Customer Admin Webhook |
|  |  |  |
| **`webhook.expiring`** | Triggered 30/20/10/1 days before a webhook expires |  Customer Admin Webhook |
|  |  |  |
| **`downloadshare.created`** | Triggered when a new download share is created in affected room | Node Webhook |
| **`downloadshare.deleted`** | Triggered when a download share is deleted in affected room | Node Webhook |
| **`downloadshare.used`** | Triggered when a download share is utilized in affected room | Node Webhook |
| **`uploadshare.created`** | Triggered when a new upload share is created in affected room | Node Webhook |
| **`uploadshare.deleted`** | Triggered when a upload share is deleted in affected room | Node Webhook |
| **`uploadshare.used`** | Triggered when a new file is uploaded via the upload share in affected room | Node Webhook |
| **`file.created`** | Triggered when a new file is uploaded in affected room | Node Webhook |
| **`folder.created`** | Triggered when a new folder is created in affected room | Node Webhook |
| **`room.created`** | Triggered when a new room is created (in affected room) | Node Webhook |
| **`file.deleted`** | Triggered when a file is deleted in affected room | Node Webhook |
| **`folder.deleted`** | Triggered when a folder is deleted in affected room | Node Webhook |
| **`room.deleted`** | Triggered when a room is deleted in affected room | Node Webhook |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Webhook_id
    Webhook ID

.EXAMPLE
    PS C:\> New-DracoonARSettingWebhook -Connection $connection -Webhook_id $webhook_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Update an existing webhook for the customer scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change config</span> required.

### Postcondition:
Webhook is updated.

### Further Information:
URL must begin with the `HTTPS` scheme.
Webhook names are limited to 150 characters.
Webhook event types can not be changed from Customer Admin Webhook types to Node Webhook types and vice versa  

### Available event types:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Name | Description | Scope |
| :--- | :--- | :--- |
| **`user.created`** | Triggered when a new user is created | Customer Admin Webhook |
| **`user.deleted`** | Triggered when a user is deleted | Customer Admin Webhook |
| **`user.locked`** | Triggered when a user gets locked | Customer Admin Webhook |
|  |  |  |
| **`webhook.expiring`** | Triggered 30/20/10/1 days before a webhook expires |  Customer Admin Webhook |
|  |  |  |
| **`downloadshare.created`** | Triggered when a new download share is created in affected room | Node Webhook |
| **`downloadshare.deleted`** | Triggered when a download share is deleted in affected room | Node Webhook |
| **`downloadshare.used`** | Triggered when a download share is utilized in affected room | Node Webhook |
| **`uploadshare.created`** | Triggered when a new upload share is created in affected room | Node Webhook |
| **`uploadshare.deleted`** | Triggered when a upload share is deleted in affected room | Node Webhook |
| **`uploadshare.used`** | Triggered when a new file is uploaded via the upload share in affected room | Node Webhook |
| **`file.created`** | Triggered when a new file is uploaded in affected room | Node Webhook |
| **`folder.created`** | Triggered when a new folder is created in affected room | Node Webhook |
| **`room.created`** | Triggered when a new room is created (in affected room) | Node Webhook |
| **`file.deleted`** | Triggered when a file is deleted in affected room | Node Webhook |
| **`folder.deleted`** | Triggered when a folder is deleted in affected room | Node Webhook |
| **`room.deleted`** | Triggered when a room is deleted in affected room | Node Webhook |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Webhook_id
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
        $__path = 'settings/webhooks/{webhook_id}' -Replace '{webhook_id}',$Webhook_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}