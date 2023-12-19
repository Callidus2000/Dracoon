function Get-DracoonSystemInfo {
    <#
    .SYNOPSIS
        Retrieves the system information of the Dracoon software using the Dracoon API.

    .DESCRIPTION
        The Get-DracoonSystemInfo function queries the Dracoon API to retrieve information about
        the version of the Dracoon software.

    .PARAMETER Connection
        Specifies the connection object to the Dracoon server. This parameter is mandatory when
        using an existing connection.

    .EXAMPLE
        $existingConnection = Get-DracoonConnection -Credential $credential -Url "https://dracoon.url"
        Get-DracoonSystemInfo -Connection $existingConnection

        Retrieves the system information of the Dracoon software using an existing connection.

    .NOTES

    #>
    param (
        [parameter(mandatory = $true, ParameterSetName = "existingConnection")]
        $connection
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/public/system/info"
        EnablePaging = $false
    }
    Invoke-DracoonAPI @apiCallParameter
}