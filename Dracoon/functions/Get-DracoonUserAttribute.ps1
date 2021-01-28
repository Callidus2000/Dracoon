function Get-DracoonUserAttribute {
    <#
    .SYNOPSIS
    Retrieve a list of user attributes. API-GET /v4/users/{user_id}/userAttributes

    .DESCRIPTION
    Retrieve a list of user attributes.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER Id
    ID of the User.

    .PARAMETER ReturnHashTable
    If set to true (default), results are returned as a HashTable. Otherwise an array of PSCustomObjects is returned

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE[:VALUE...]
    Example:

    key:cn:searchString_1|value:cn:searchString_2
    Filter by attribute key contains searchString_1 AND attribute value contains searchString_2.

    .PARAMETER Limit
    Range limit. Maximum 500.
    For more results please use paging (offset + limit).

    .PARAMETER Offset
    Range offset

    .PARAMETER Sort
    Sort string syntax: FIELD_NAME:ORDER
    ORDER can be asc or desc.
    Multiple sort fields are NOT supported.
    Nodes are sorted by type first, then by sent sort string.
    Example:

    name:desc

    .PARAMETER EnablePaging
    Wenn die API mit Paging arbeitet, kann über diesn Parameter ein automatisches Handling aktivieren.
    Dann werden alle Pages abgehandelt und nur die items zurückgeliefert.


    .EXAMPLE
    To be added
    in the Future
    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        [Dracoon]$connection,
        [parameter(Mandatory)]
        [int]$Id,
        [bool]$ReturnHashTable = $true,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit = 500,
        [int]$Offset = 0,
        [string]$Sort,
        [bool]$EnablePaging = $true

    )
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Get"
        Path       = "/v4/users/$Id/userAttributes"
        EnablePaging = $EnablePaging
        UrlParameter = @{
            filter             = $Filter
            limit              = $Limit
            sort               = $Sort
            offset             = $offset
        }
    }
    Write-PSFMessage "Ermittele UserAttribute zu User $Id"
    $results = Invoke-DracoonAPI @apiCallParameter
    if ($EnablePaging) { $items = $results }else { $items = $results.items}
    if ($ReturnHashTable) {
        $attributes = @{}
        foreach ($item in $items ) {
            $attributes.add($item.key, $item.value)
        }
        $attributes
    }
    else {
        $items
    }
}