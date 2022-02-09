function Remove-DracoonARProvisioningCustomerCustomerattribute {
<#
.SYNOPSIS
    Remove customer attribute

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:
Delete a custom customer attribute.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> required.

### Postcondition:
Custom customer attribute gets deleted.

### Further Information:
* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.

.PARAMETER Key
    Key

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Customer_id
    Customer ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARProvisioningCustomerCustomerattribute -Key $key -Customer_id $customer_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:
Delete a custom customer attribute.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> required.

### Postcondition:
Custom customer attribute gets deleted.

### Further Information:
* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Key,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsServiceToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Customer_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsServiceToken' = 'X-Sds-Service-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken') -Mapping $__mapping
        $__path = 'provisioning/customers/{customer_id}/customerAttributes/{key}' -Replace '{key}',$Key -Replace '{customer_id}',$Customer_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}