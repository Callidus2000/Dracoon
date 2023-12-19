﻿function Get-DracoonCurrentCustomer {
    <#
    .SYNOPSIS
    Retrieves all information regarding the current user’s customer account. API-GET /v4/user/account/customer

    .DESCRIPTION
    Retrieves all information regarding the current user’s account. API-GET /v4/user/account/customer

    .PARAMETER Connection
    Parameter description

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        $Connection
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/user/account/customer"
    }

    Invoke-DracoonAPI @apiCallParameter
}