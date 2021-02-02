function Invoke-DracoonAPI {
    <#
    .SYNOPSIS
    Generic API Call to the Dracoon API.

    .DESCRIPTION
    Generic API Call to the Dracoon API.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER Path
    API Path to the REST function

    .PARAMETER Body
    Parameter for the API call; Converted to the POST body

    .PARAMETER UrlParameter
    Parameter for the API call; Converted to the GET URL parameter set

    .PARAMETER Method
    HTTP Method

    .PARAMETER ContentType
    HTTP-ContentType, defaults to "application/json;charset=UTF-8"

    .PARAMETER InFile
    File which should be transfered during the Request.

    .PARAMETER HideParameters
    If set to $true the password is hidden from logging

    .PARAMETER EnablePaging
    Wenn die API mit Paging arbeitet, kann über diesn Parameter ein automatisches Handling aktivieren.
    Dann werden alle Pages abgehandelt und nur die items zurückgeliefert.

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
        [Hashtable] $UrlParameter,
        [parameter(Mandatory)]
        [Microsoft.Powershell.Commands.WebRequestMethod]$Method,
        [bool] $HideParameters = $false,
        [string]$ContentType = "application/json;charset=UTF-8",
        [string]$InFile,
        [bool]$EnableException=$true,
        [switch]$EnablePaging
    )
    $uri = $connection.webServiceRoot + $path
    if ($UrlParameter) {
        Write-PSFMessage "Wandle URL Parameter in String um und hänge diese an die URI"
        $parameterString = (Get-EncodedParameterString($UrlParameter))
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
            $UrlParameter.limit = $result.range.limit
            $UrlParameter.offset = $result.range.offset
            while ($result.range.total -gt $allItems.count) {
                Write-PSFMessage "result.range.total=$($result.range.total) -gt allItems.count=$($allItems.count)"
                $UrlParameter.offset = $allItems.count
                $nextParameter = @{
                    Connection     = $Connection
                    Path           = $Path
                    Body           = $Body
                    UrlParameter   = $UrlParameter
                    Method         = $Method
                    HideParameters = $HideParameters
                }
                write-psfmessage "Rufe API auf mit $($nextParameter|convertto-json -depth 10)" -Level Debug
                write-psfmessage "Rufe API auf mit URL Params auf $($UrlParameter|convertto-json -depth 10)"

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
    #---------------------------------------------------------------------------------
    # Ist das Objekt zu groß wird es als String und nicht als PSCustomObject
    # ausgegeben. Dieses wird dann mit dieser Methode in ein .DictionaryEntry-Object
    # umgewandelt, um damit arbeiten zu können.
    #---------------------------------------------------------------------------------
    # if ($result.gettype().name -eq "String") {
    #     $jsonresult = $connection.jsonserial.DeserializeObject($result)
    #     return $jsonresult
    # }
    # else {
    return $result
    # }
}