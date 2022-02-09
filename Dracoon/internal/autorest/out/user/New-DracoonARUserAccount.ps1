function New-DracoonARUserAccount {
<#
.SYNOPSIS
    Update user account

.DESCRIPTION
    ### Description:  
Update current user's account.

### Precondition:
Authenticated user.

### Postcondition:
User's account is updated.

### Further Information:
* All input fields are limited to **150** characters.  
* **All** characters are allowed.  

`customer` (`CustomerData`) attribute in `UserAccount` response model is deprecated. Please use response from `GET /user/account/customer` instead.

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARUserAccount -Connection $connection

    ### Description:  
Update current user's account.

### Precondition:
Authenticated user.

### Postcondition:
User's account is updated.

### Further Information:
* All input fields are limited to **150** characters.  
* **All** characters are allowed.  

`customer` (`CustomerData`) attribute in `UserAccount` response model is deprecated. Please use response from `GET /user/account/customer` instead.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsAuthToken') -Mapping $__mapping
        $__path = 'user/account'
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}