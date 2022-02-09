function Set-DracoonARProvisioningCustomerCustomerattribute {
<#
.SYNOPSIS
    Set customer attributes

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:  
Set custom customer attributes.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> required.

### Postcondition:
Custom customer attributes gets set.

### Further Information:
Batch function.  
All existing customer attributes will be deleted.  

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.


.PARAMETER XSdsServiceToken
    Service Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Customer_id
    Customer ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> Set-DracoonARProvisioningCustomerCustomerattribute -Customer_id $customer_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.4.0</h3>

### Description:  
Set custom customer attributes.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> required.

### Postcondition:
Custom customer attributes gets set.

### Further Information:
Batch function.  
All existing customer attributes will be deleted.  

* Allowed characters for keys are: `[a-zA-Z0-9_-]`  
* Characters are **case-insensitive**.


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsServiceToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

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
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsServiceToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'provisioning/customers/{customer_id}/customerAttributes' -Replace '{customer_id}',$Customer_id
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}