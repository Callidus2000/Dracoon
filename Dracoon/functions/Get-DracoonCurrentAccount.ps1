function Get-DracoonCurrentAccount {
    <#
    .SYNOPSIS
    Retrieves all information regarding the current user’s account. API-GET /v4/user/account

    .DESCRIPTION
    Retrieves all information regarding the current user’s account. API-GET /v4/user/account

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
        [Dracoon]$Connection
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/user/account"
    }

    Invoke-DracoonAPI @apiCallParameter
}