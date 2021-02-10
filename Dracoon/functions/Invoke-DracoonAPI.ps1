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
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL. Can be obtained with Connect-Dracoon.

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

    .PARAMETER HideParameters
    If set to $true the password is hidden from logging

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
        [bool] $HideParameters = $false,
        [string]$ContentType = "application/json;charset=UTF-8",
        [string]$InFile,
        [bool]$EnableException=$true,
        [switch]$EnablePaging
    )
    $uri = $connection.webServiceRoot + $path
    if ($URLParameter) {
        Write-PSFMessage "Wandle URL Parameter in String um und hänge diese an die URI"
        $parameterString = (Get-EncodedParameterString($URLParameter))
        $uri = $uri + '?' + $parameterString.trim("?")
    }
    $restAPIParameter = @{
        Uri         = $Uri
        method      = $Method
        body        = ($Body | Remove-NullFromHashtable -Json)
        Headers     = $connection.headers
        ContentType = $ContentType
    }
    If ($Body) {
        $restAPIParameter.body = ($Body | Remove-NullFromHashtable -Json)
    }
    If ($InFile) {
        $restAPIParameter.InFile = $InFile
    }
    Write-PSFMessage -Message "$(("$Method").ToUpper()) $uri" -Target $connection

    $tempBody = $body
    if ($hideParameters) {
        if ($tempBody.ContainsKey("password")) { $tempBody.set_Item("password", "*****") }
    }
    if ($tempBody) {
        Write-PSFMessage ("Rufe {0} mit {1} auf" -f $uri, ($tempBody  | Remove-NullFromHashtable -Json))
    }
    else {
        Write-PSFMessage ("Rufe {0} auf" -f $uri)
    }

    try {
        Write-PSFMessage -Level Debug "restAPIParameter= $($restAPIParameter|ConvertTo-Json -Depth 5)"
        $result = Invoke-RestMethod @restAPIParameter
        Write-PSFMessage -Level Debug "result= $($result|ConvertTo-Json -Depth 5)"
        if ($EnablePaging -and ($result -is [array])) {
            Write-PSFMessage "Paging enabled, aber keine Range zurückgeliefert" -Level Warning
        }elseif ($EnablePaging) {
            Write-PSFMessage "Paging enabled, starte Schleife, result.range=$($result.range)"
            $allItems = ($result.items)
            write-psfmessage "Anzahl ermittelter Items: $($allItems.count)"
            $URLParameter.limit = $result.range.limit
            $URLParameter.offset = $result.range.offset
            while ($result.range.total -gt $allItems.count) {
                Write-PSFMessage "result.range.total=$($result.range.total) -gt allItems.count=$($allItems.count)"
                $URLParameter.offset = $allItems.count
                $nextParameter = @{
                    Connection     = $Connection
                    Path           = $Path
                    Body           = $Body
                    URLParameter   = $URLParameter
                    Method         = $Method
                    HideParameters = $HideParameters
                }
                write-psfmessage "Rufe API auf mit $($nextParameter|convertto-json -depth 10)" -Level Debug
                write-psfmessage "Rufe API auf mit URL Params auf $($URLParameter|convertto-json -depth 10)"

                $result = Invoke-DracoonAPI @nextParameter
                $allItems += ($result.items)
            }
            return $allItems
        }
    }
    catch {
        $result = $_.errordetails
        Write-PSFMessage "$result" -Level Critical
        If ($EnableException){
            throw $_#$result.Message
        }else{
            return
        }
    }
    return $result
}