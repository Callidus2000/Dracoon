#     [PSCustomObject]SetUserAttributes([int]$userId, [Hashtable]$userAttributes, [bool]$keepExisting) {
#         $items = @()

#         foreach ($key in $userAttributes.Keys) {
#             $items += @{ key = $key ; value = $userAttributes[$key] }
#         }
#         $parameter = @{items = $items }
#         if ($keepExisting) {
#             $result = $this.InvokePut("/v4/users/$userId/userAttributes", $parameter)
#         }
#         else {
#             $result = $this.InvokePost("/v4/users/$userId/userAttributes", $parameter)
#         }
#         return $result
#     }

function Set-DracoonUserAttribute {
    <#
    .SYNOPSIS
    Set custom user attributes. API-(POST/PUT) /v4/users/{user_id}/userAttributes

    .DESCRIPTION
    Set custom user attributes. Uses POST for overwriting the userAttributes or PUT for updating the userAttributes.

    .PARAMETER Connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER id
    ID of the user to be changed.

    .PARAMETER UserAttributes
    HashTable wit the UserAttributes.

    .PARAMETER Overwrite
    Shall all exisiting attributes be overwritten? Default False.

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    To be added
    in the Future

    .NOTES
    If the operation fails the function throws the exception
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [parameter(mandatory = $true)]
        $Connection,
        [parameter(Mandatory)]
        [int]$Id,
        [Hashtable]$UserAttributes,
        [bool]$Overwrite = $false
    )
    $itemArray = @()
    Write-PSFMessage "Setze User-Attribute für User $id auf $UserAttributes"
    foreach ($key in $UserAttributes.Keys) {
        $itemArray += @{ key = $key ; value = $userAttributes[$key] }
    }
    if ($Overwrite) { $method = "Post" }else { $method = "Put" }

    $apiCallParameter = @{
        Connection = $Connection
        method     = $method
        Path       = "/v4/users/$Id/userAttributes"
        Body       = @{items = $itemArray }
    }

    Invoke-PSFProtectedCommand -Action "Setting attributes on user" -Target "$Id" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        Write-PSFMessage "Attribute set"
        $result
    } -PSCmdlet $PSCmdlet -EnableException $true
}