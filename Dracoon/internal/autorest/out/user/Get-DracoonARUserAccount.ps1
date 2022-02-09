function Get-DracoonARUserAccount {
<#
.SYNOPSIS
    Request user account information

.DESCRIPTION
    ### Description:  
Retrieves all information regarding the current user's account.

### Precondition:
Authenticated user.

### Postcondition:
User information is returned.

### Further Information:
Setting the query parameter `more_info` to `true`, causes the API to return more details e.g. the user's groups.  

`customer` (`CustomerData`) attribute in `UserAccount` response model has been removed. Please use response from `GET /user/account/customer` instead.

.PARAMETER More_info
    Get more info for this user

e.g. list of user groups

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARUserAccount -Connection $connection

    ### Description:  
Retrieves all information regarding the current user's account.

### Precondition:
Authenticated user.

### Postcondition:
User information is returned.

### Further Information:
Setting the query parameter `more_info` to `true`, causes the API to return more details e.g. the user's groups.  

`customer` (`CustomerData`) attribute in `UserAccount` response model has been removed. Please use response from `GET /user/account/customer` instead.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $More_info,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'More_info' = 'more_info'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('More_info') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsDateFormat','XSdsAuthToken') -Mapping $__mapping
        $__path = 'user/account'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}