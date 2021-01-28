function Get-DracoonUser {
    <#
    .SYNOPSIS
    Query of all Users. API-GET /v4/users oder /v4/users/$Id

    .DESCRIPTION
    Function has two modes: Single or Multi-Users.
    If using in Multi-User Mode (without Id parameter) it returns an array of all users.

    .PARAMETER Connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL.

    .PARAMETER Filter
    All filter fields are connected via logical conjunction (AND)
    Except for login, firstName and lastName - these are connected via logical disjunction (OR)
    Filter string syntax: FIELD_NAME:OPERATOR:VALUE[:VALUE...]
    Example:
    login:cn:searchString_1|firstName:cn:searchString_2|lockStatus:eq:2
    Filter users by login contains searchString_1 OR firstName contains searchString_2 AND those who are NOT locked.

    effectiveRoles
    Filter users with DIRECT or DIRECT AND EFFECTIVE roles
        false: DIRECT roles
        true: DIRECT AND EFFECTIVE roles
        DIRECT means: e.g. user gets role directly granted from someone with grant permission right.
        EFFECTIVE means: e.g. user gets role through group membership.

    .PARAMETER IncludeAttributes
    Parameter description

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

    .PARAMETER Id
    Id of a specific user.

    .PARAMETER EffectiveRoles
    Filter users with DIRECT or DIRECT AND EFFECTIVE roles.
        false: DIRECT roles
        true: DIRECT AND EFFECTIVE roles
    DIRECT means: e.g. user gets role directly granted from someone with grant permission right.
    EFFECTIVE means: e.g. user gets role through group membership.

    .EXAMPLE
    To be added
    in the Future

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = "SingleUser")]
    Param (
        [parameter(Mandatory)]
        [Dracoon]$Connection,
        [PSFramework.TabExpansion.PsfArgumentCompleterAttribute("Dracoon.filter")]
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [string]$Filter,
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [int]$Limit=500,
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [int]$Offset=0,
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [switch]$IncludeAttributes,
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [string]$Sort,
        [parameter(Mandatory = $false, ParameterSetName = "MultipleUsers")]
        [bool]$EnablePaging=$true,
        [parameter(Mandatory = $false, ParameterSetName = "SingleUser")]
        [int]$Id,
        [parameter(Mandatory = $false, ParameterSetName = "SingleUser")]
        [bool]$EffectiveRoles=$true
    )
    if ($id -eq 0){
        Write-PSFMessage "Ermittle mehrere User"
        $apiCallParameter = @{
            Connection   = $Connection
            method       = "Get"
            Path         ="/v4/users"
            EnablePaging = $EnablePaging
            UrlParameter = @{
                filter=$Filter
                include_attributes=$IncludeAttributes
                limit=$Limit
                sort=$Sort
                offset=$offset
            }
        }
    }else{
        Write-PSFMessage "Requesting detailed user info for #$Id"
        $apiCallParameter = @{
            Connection   = $Connection
            method       = "Get"
            Path         ="/v4/users/$Id"
            UrlParameter = @{
                effective_roles    = $EffectiveRoles
            }
        }

    }

    Invoke-DracoonAPI @apiCallParameter
}