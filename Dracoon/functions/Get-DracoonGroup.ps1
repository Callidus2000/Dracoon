function Get-DracoonGroup {
    <#
    .SYNOPSIS
    Returns a list of user groups. API-GET /v4/groups

    .DESCRIPTION
    Returns a list of user groups.

    .PARAMETER Connection
    Parameter description

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE
    Possible combinations:
    'name:cn:[search String]'

    .PARAMETER Limit
    Range limit. Maximum 500.
    For more results please use paging (offset + limit).

    .PARAMETER Offset
    Range offset

    .PARAMETER Sort
    Sort string syntax: FIELD_NAME:ORDER
    ORDER can be asc or desc.
    Multiple sort fields are supported.
    Example:

    name:asc|expireAt:desc
    Sort by name ascending AND by expireAt descending.

    Possible fields:
    name	Group name
    createdAt	Creation date
    expireAt	Expiration date
    cntUsers	Amount of users

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
        $Connection,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [string]$Filter,
        [int]$Limit=500,
        [int]$Offset=0,
        [string]$Sort,
        [bool]$EnablePaging=$true
    )
    $apiCallParameter = @{
        Connection   = $Connection
        method       = "Get"
        Path         ="/v4/groups"
        EnablePaging = $EnablePaging
        UrlParameter = @{
            filter=$Filter
            limit=$Limit
            sort=$Sort
            offset=$offset
        }
    }

    Invoke-DracoonAPI @apiCallParameter
}