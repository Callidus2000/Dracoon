function New-DracoonARNodeComment {
<#
.SYNOPSIS
    Edit node comment

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.10.0</h3>

### Description:
Edit the text of an existing comment for a specific node.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions on the node and is the creator of the comment.

### Postcondition:
Comments text gets changed.

### Further Information:
Maximum allowed text length: **65535** characters.

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Comment_id
    Comment ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARNodeComment -Comment_id $comment_id -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.10.0</h3>

### Description:
Edit the text of an existing comment for a specific node.

### Precondition:
User has <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span> permissions on the node and is the creator of the comment.

### Postcondition:
Comments text gets changed.

### Further Information:
Maximum allowed text length: **65535** characters.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Comment_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'nodes/comments/{comment_id}' -Replace '{comment_id}',$Comment_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}