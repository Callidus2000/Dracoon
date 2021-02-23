function Invoke-DracoonAPI {
    <#
    .SYNOPSIS
    Generic API Call to the Dracoon API.

    .DESCRIPTION
    Generic API Call to the Dracoon API. This function is a wrapper for the usage of Invoke-WebRequest. It handles some annoying repetitive tasks which occur in most use cases. This includes (list may be uncompleted)
    - Connecting to a server with authentication
    - Parsing API parameter
    - Handling $null parameter
    - Paging for API endpoints which do only provide limited amounts of datasets

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL. Can be obtained with Connect-Dracoon.

    .PARAMETER Path
    API Path to the REST function, starting *after* /api.
    Example: "/v4/users"

    .PARAMETER Body
    Parameter for the API call; The hashtable is Converted to the POST body by using ConvertTo-Json

    .PARAMETER URLParameter
    Parameter for the API call; Converted to the GET URL parameter set.
    Example:
    {
        id=4
        name=Jon Doe
    }
    will result in "?id=4&name=Jon%20Doe" being added to the URL Path

    .PARAMETER Method
    HTTP Method, Get/Post/Delete/Put/...

    .PARAMETER ContentType
    HTTP-ContentType, defaults to "application/json;charset=UTF-8"
    See Publish-DracoonFile for usage.

    .PARAMETER InFile
    File which should be transferred during the Request.
    See Publish-DracoonFile for usage.

    .PARAMETER EnablePaging
    If the API makes use of paging (therefor of limit/offset URLParameter) setting EnablePaging to $true will not return the raw data but a combination of all data sets.

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    $result = Invoke-DracoonAPI -connection $this -path "/v4/auth/login" -method POST -body @{login = $credentials.UserName; password = $credentials.GetNetworkCredential().Password; language = "1"; authType = "sql" } -hideparameters $true
    Login to the service

    .NOTES
    General notes
    #>

    param (
        [parameter(Mandatory)]
        $Connection,
        [parameter(Mandatory)]
        [string]$Path,
        [Hashtable] $Body,
        [Hashtable] $URLParameter,
        [parameter(Mandatory)]
        [Microsoft.Powershell.Commands.WebRequestMethod]$Method,
        [string]$ContentType = "application/json;charset=UTF-8",
        [string]$InFile,
        [bool]$EnableException=$true,
        [switch]$EnablePaging
    )
    return Invoke-ARAHRequest @PSBoundParameters -PagingHandler 'Dracoon.PagingHandler'
}