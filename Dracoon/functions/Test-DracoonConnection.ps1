function Test-DracoonConnection {
    <#
    .SYNOPSIS
    Test connection to DRACOON Server. API-GET /v4/auth/ping

    .DESCRIPTION
    Test connection to DRACOON Server. API-GET /v4/auth/ping

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .EXAMPLE
    Test-DracoonConnection $connection
    Throws a [System.Net.NetworkInformation.PingException] if connection does not succeed, otherwise
    it returns $true

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
        Path       = "/v4/config/info/infrastructure"
    }
try {
    $result=Invoke-DracoonAPI @apiCallParameter -EnableException $true
    Write-PSFMessage "Ping result: $result"
    # if ($result -notmatch '^OK'){
    #     throw [System.Net.NetworkInformation.PingException]::new("API not pingable, $($connection.serverRoot)/v4/auth/ping")
    # }
}
catch {
    return $false
    # throw [System.Net.NetworkInformation.PingException]::new("API not pingable, $($connection.serverRoot)/v4/auth/ping")
}
    $true
}