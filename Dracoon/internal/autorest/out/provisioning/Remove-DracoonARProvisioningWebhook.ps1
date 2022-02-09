function Remove-DracoonARProvisioningWebhook {
<#
.SYNOPSIS
    Remove tenant webhook

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Delete a webhook for the tenant scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage webhook</span> required.

### Postcondition:
Webhook is deleted.

### Further Information:
None.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Webhook_id
    Webhook ID

.EXAMPLE
    PS C:\> Remove-DracoonARProvisioningWebhook -Connection $connection -Webhook_id $webhook_id

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.19.0</h3>

### Description:  
Delete a webhook for the tenant scope.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage webhook</span> required.

### Postcondition:
Webhook is deleted.

### Further Information:
None.

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

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Webhook_id
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsServiceToken' = 'X-Sds-Service-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/webhooks/{webhook_id}' -Replace '{webhook_id}',$Webhook_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}