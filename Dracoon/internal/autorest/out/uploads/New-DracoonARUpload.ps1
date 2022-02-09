function New-DracoonARUpload {
<#
.SYNOPSIS
    Complete file upload

.DESCRIPTION
    ### Description:
Finish uploading a file.

### Precondition:
Valid upload token.

### Postcondition:
File created.

### Further Information:
The provided file name might be changed in accordance with the resolution strategy:

* **autorename**: changes the file name and adds a number to avoid conflicts.
* **overwrite**: deletes any old file with the same file name.
* **fail**: returns an error; in this case, another `PUT` request with a different file name may be sent.

Please ensure that all chunks have been transferred correctly before finishing the upload.

Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Token
    Upload token

.EXAMPLE
    PS C:\> New-DracoonARUpload -Connection $connection -Token $token

    ### Description:
Finish uploading a file.

### Precondition:
Valid upload token.

### Postcondition:
File created.

### Further Information:
The provided file name might be changed in accordance with the resolution strategy:

* **autorename**: changes the file name and adds a number to avoid conflicts.
* **overwrite**: deletes any old file with the same file name.
* **fail**: returns an error; in this case, another `PUT` request with a different file name may be sent.

Please ensure that all chunks have been transferred correctly before finishing the upload.

Download share id (if exists) gets changed if:
- node with the same name exists in the target container
- `resolutionStrategy` is `overwrite`
- `keepShareLinks` is `true`

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Token
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'uploads/{token}' -Replace '{token}',$Token
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}