function Get-DracoonVersion {
    <#
    .SYNOPSIS
        Retrieves the version information of the Dracoon software using the Dracoon API.

    .DESCRIPTION
        The Get-DracoonVersion function queries the Dracoon API to retrieve information about
        the version of the Dracoon software.

    .PARAMETER Connection
        Specifies the connection object to the Dracoon server. This parameter is mandatory when
        using an existing connection.

    .EXAMPLE
        $existingConnection = Get-DracoonConnection -Credential $credential -Url "https://dracoon.url"
        Get-DracoonVersion -Connection $existingConnection

        Retrieves the version information of the Dracoon software using an existing connection.

    .NOTES

    #>
    param (
        [parameter(mandatory = $true, ParameterSetName = "existingConnection")]
        $connection
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/public/software/version"
        EnablePaging = $false
    }
    Invoke-DracoonAPI @apiCallParameter
}