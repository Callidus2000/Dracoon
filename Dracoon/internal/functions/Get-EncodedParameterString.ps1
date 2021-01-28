function Get-EncodedParameterString {
    <#
    .SYNOPSIS
    Converts a hashtable to GET Parameters

    .DESCRIPTION
    Converts a hashtable to GET Parameters.

    .PARAMETER parameter
    Hashtable with the GET Parameters

    .EXAMPLE
    Get-EncodedParameterString -parameter @{key1="value1";key2="value2"}
    Returns the string: key1=value1&key2=value2

    .NOTES
    General notes
    #>

    param (
        [parameter(Mandatory,Position=1)]
        [Hashtable]$parameter
    )
    $getParameter = @()
    if ($parameter) {
        foreach ($key in $parameter.Keys) {
            $value = $parameter[$key]
            if ($value) {
                switch ($value.GetType()) {
                    bool { $value = $value.ToString() }
                    Default { }
                }
                $valueEncoded = [System.Web.HttpUtility]::UrlEncode($value)
                $getParameter += "$key=$valueEncoded"
            }
        }
    }
    return ($getParameter -join "&")
}