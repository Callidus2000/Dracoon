function New-DracoonARProvisioningWebhook {
<#
.SYNOPSIS
    Update tenant webhook

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Update an existing webhook for the tenant scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage webhook</span> required.

### Postcondition:
Webhook is updated.

### Further Information:
URL must begin with the `HTTPS` scheme.
Webhook names are limited to 150 characters.

### Available event types:

<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Name | Description | Scope |
| :--- | :--- | :--- |
| **`customer.created`** | Triggered when a new customer is created | Tenant Webhook |
| **`customer.deleted`** | Triggered when a user is deleted | Tenant Webhook |
| **`webhook.expiring`** | Triggered 30/20/10/1 days before a webhook expires |  Tenant Webhook |

</details>

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Webhook_id
    Webhook ID

.EXAMPLE
    PS C:\> New-DracoonARProvisioningWebhook -Connection $connection -Webhook_id $webhook_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Update an existing webhook for the tenant scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage webhook</span> required.

### Postcondition:
Webhook is updated.

### Further Information:
URL must begin with the `HTTPS` scheme.
Webhook names are limited to 150 characters.

### Available event types:

<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Name | Description | Scope |
| :--- | :--- | :--- |
| **`customer.created`** | Triggered when a new customer is created | Tenant Webhook |
| **`customer.deleted`** | Triggered when a user is deleted | Tenant Webhook |
| **`webhook.expiring`** | Triggered 30/20/10/1 days before a webhook expires |  Tenant Webhook |

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
        $XSdsServiceToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Webhook_id
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsServiceToken' = 'X-Sds-Service-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'provisioning/webhooks/{webhook_id}' -Replace '{webhook_id}',$Webhook_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}