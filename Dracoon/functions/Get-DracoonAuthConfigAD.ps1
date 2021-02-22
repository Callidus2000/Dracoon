function Get-DracoonAuthConfigAD{
    <#
    .SYNOPSIS
    Retrieve a list of configured Active Directories. API-GET /v4/system/config/auth/ads

    .DESCRIPTION
    Retrieve a list of configured Active Directories. API-GET /v4/system/config/auth/ads
    Right “read global config” required.
    Role Config Manager of the Provider Customer.

    .PARAMETER Connection
    Parameter description

    .PARAMETER Alias
    Returns only the configuration whose "alias" attribute matches the parameter value
    .EXAMPLE
    To be added
    in the Future
    #>
        param (
        [parameter(Mandatory)]
        $Connection,
        [string]$Alias
        )
        $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/system/config/auth/ads"

    }

    $result=Invoke-DracoonAPI @apiCallParameter
    if ($Alias){
        $result.items|where-object {$_.Alias -eq $Alias}
    }else{
        $result.items
    }
}