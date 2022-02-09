function Remove-DracoonARProvisioningCustomer {
<#
.SYNOPSIS
    Remove customer

.DESCRIPTION
    ### Description:
Delete a customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
Customer is deleted.

### Further Information:
None.

.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER Customer_id
    Customer ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Remove-DracoonARProvisioningCustomer -Customer_id $customer_id -Connection $connection

    ### Description:
Delete a customer.

### Precondition:
Authentication with `X-Sds-Service-Token` required.

### Postcondition:
Customer is deleted.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
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
        $__path = 'provisioning/customers/{customer_id}' -Replace '{customer_id}',$Customer_id
        Invoke-DracoonAPI -Path $__path -Method delete -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}