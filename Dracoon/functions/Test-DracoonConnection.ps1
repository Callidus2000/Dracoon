function Test-DracoonConnection {
    <#
    .SYNOPSIS
    Test connection to DRACOON Server. API-GET /v4/auth/ping

    .DESCRIPTION
    Test connection to DRACOON Server. API-GET /v4/auth/ping

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .EXAMPLE
    Test-DracoonConnection $connection
    Throws a [System.Net.NetworkInformation.PingException] if connection does not succeed, otherwise
    it returns $true

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
        Path         ="/v4/auth/ping"
    }
try {
    $result=Invoke-DracoonAPI @apiCallParameter
    Write-PSFMessage "Ping result: $result"
    if ($result -notmatch '^OK'){
        throw [System.Net.NetworkInformation.PingException]::new("API not pingable, $($connection.serverRoot)/v4/auth/ping")
    }
}
catch {
    throw [System.Net.NetworkInformation.PingException]::new("API not pingable, $($connection.serverRoot)/v4/auth/ping")
}
    $true
}