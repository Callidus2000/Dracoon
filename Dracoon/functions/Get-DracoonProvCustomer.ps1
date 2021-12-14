function Get-DracoonProvCustomer {
    <#
    .SYNOPSIS
    Get list of customers

    .DESCRIPTION
    Receive a list of customers.

    .PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL
    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE
    Example:

    permissionsManage:eq:true|user:cn:searchString
    Get all users that have manage permissions to this room AND whose (firstname OR lastname OR email) is like searchString.

    Possible combinations:
    'id:[eq]:[positive Integer]'
    'companyName:[cn]:[search String]'
    'customerContractType:[eq]:[demo]'
    'activationCode:[cn, eq]:[search String]'
    'trialDaysLeft:[ge, le]:[trialDaysLeft:ge:5]'
    'providerCustomerId:[cn, eq]:[search String]'
    'quotaMax:[ge, le]:[quotaMax:ge:1024]'
    'quotaUsed:[ge, le]:[quotaUsed:ge:1024]'
    'userMax:[ge, le]:[userMax:ge:10]'
    'userUsed:[ge, le]:[userUsed:ge:10]'

    .PARAMETER Limit
    Range limit. Maximum 500.
    For more results please use paging (offset + limit).

    .PARAMETER Offset
    Range offset

    .PARAMETER ID
    ID of the customer whoose data should be returned.

    .PARAMETER Sort
    Sort string syntax: `FIELD_NAME:ORDER`
    `ORDER` can be `asc` or `desc`.
    Multiple sort fields are **NOT** supported.
    Example:
    > `companyName:desc`
    Sort by `companyName` descending.

    | `FIELD_NAME` | Description |
    | :--- | :--- |
    | **`companyName`** | Company name |
    | **`customerContractType`** | Customer contract type |
    | **`trialDaysLeft`** | Number of remaining trial days (demo customers) |
    | **`providerCustomerId`** | Provider Customer ID |
    | **`quotaMax`** | Maximum quota |
    | **`quotaUsed`** | Currently used quota |
    | **`userMax`** | Maximum user number |
    | **`userUsed`** | Number of registered users |
    | **`lockStatus`** | (**`DEPRECATED`**) Lock status of customer |
    | **`isLocked`** | Lock status of customer |
    | **`createdAt`** | Creation date |
    | **`updatedAt`** | Last modification date |
    | **`lastLoginAt`** | Last login date of any user of this customer |

    .PARAMETER EnablePaging
    Wenn die API mit Paging arbeitet, kann über diesn Parameter ein automatisches Handling aktivieren.
    Dann werden alle Pages abgehandelt und nur die items zurückgeliefert.

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    ToBeFilledOut

    Including Remarks

    .NOTES
    Authentication with `X-Sds-Service-Token` required.

    #>
    param (
        [parameter(mandatory = $true, ParameterSetName = "allCustomers")]
        [parameter(mandatory = $true, ParameterSetName = "singleCustomer")]
        $Connection,
        [parameter(mandatory = $false, ParameterSetName = "allCustomers")]
        [string]$Filter,
        [parameter(mandatory = $false, ParameterSetName = "allCustomers")]
        [string]$Sort,
        [parameter(mandatory = $true, ParameterSetName = "singleCustomer")]
        [int]$Id,
        [parameter(mandatory = $false, ParameterSetName = "allCustomers")]
        [int]$Limit = 500,
        [parameter(mandatory = $false, ParameterSetName = "allCustomers")]
        [int]$Offset = 0,
        [parameter(mandatory = $false, ParameterSetName = "allCustomers")]
        [bool]$EnablePaging = $true
    )
    begin {
    }
    process {
    }
    end {
        $apiCallParameter = @{
            Connection   = $Connection
            method       = "get"
            EnablePaging = $EnablePaging
            UrlParameter = @{
                filter = $Filter
                limit  = $Limit
                offset = $offset
                sort   = $Sort
            }
        }
        switch ($PSCmdlet.ParameterSetName){
            'allCustomers' {
                $apiCallParameter.Path         = "/v4/provisioning/customers"
                $apiCallParameter.UrlParameter = @{
                    filter = $Filter
                    limit  = $Limit
                    offset = $offset
                    sort   = $Sort
                }
            }
            'singleCustomer' {
                $apiCallParameter.Path         = "/v4/provisioning/customers/$Id"
            }
        }

        Invoke-PSFProtectedCommand -Action "Get customers" -Target $FileName -ScriptBlock {
            $result = Invoke-DracoonAPI @apiCallParameter
            if ($result.items){
                return $result.items
            }

                return $result

        } -PSCmdlet $PSCmdlet -EnableException $EnableException -RetryCount 4 -RetryWait 5
    }
}