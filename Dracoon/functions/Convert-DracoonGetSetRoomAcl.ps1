function Convert-DracoonGetSetRoomAcl {
    <#
    .SYNOPSIS
    Converts Information retrieved from Get-DracoonRoomAcl to be used for Set-DracoonRoomAcl.

    .DESCRIPTION
    Converts Information retrieved from Get-DracoonRoomAcl to be used for Set-DracoonRoomAcl.
    Get-DracoonRoomAcl returns an array in the following format:
    {
      "userInfo": {
        "id": 0,
        "userType": "internal",
        "avatarUuid": "string",
        "displayName": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "title": "string"
      },
      "isGranted": true,
      "id": 0,
      "login": "string",
      "displayName": "string",
      "email": "john.doe@email.com",
      "permissions": {
        "manage": true,
        "read": true,
        "create": true,
        "change": true,
        "delete": true,
        "manageDownloadShare": true,
        "manageUploadShare": true,
        "readRecycleBin": true,
        "restoreRecycleBin": true,
        "deleteRecycleBin": true
      },
      "publicKeyContainer": {
        "version": "A",
        "publicKey": "string"
      }
    }

    Set-DracoonRoomAcl needs only a sub-part as an array:
    {
      "id": 0,
      "permissions": {
        "manage": true,
        "read": true,
        "create": true,
        "change": true,
        "delete": true,
        "manageDownloadShare": true,
        "manageUploadShare": true,
        "readRecycleBin": true,
        "restoreRecycleBin": true,
        "deleteRecycleBin": true
      }
    }

    This function converts the different formats.

    .PARAMETER ExistingPermissions
    Array of the exisiting Permission Items.

    .EXAMPLE
    To be added

    in the Future

    .NOTES
    General notes
    #>
    param (
        [parameter(Mandatory)]
        [array]$ExistingPermissions
    )
    Write-PSFMessage "Converting Permissions "
    Write-PSFMessage "Current permissions: $($ExistingPermissions|convertto-json -depth 10)"
    $permissionList = @()
    foreach ($item in $ExistingPermissions) {
        $permissionList += @{id = $item.id; permissions = $item.permissions }
    }
    Write-PSFMessage "Neue Berechtigungen: $($permissionList|convertto-json -depth 10)"
    $permissionList
}