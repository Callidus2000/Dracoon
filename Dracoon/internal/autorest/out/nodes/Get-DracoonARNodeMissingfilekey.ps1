﻿function Get-DracoonARNodeMissingfilekey {
<#
.SYNOPSIS
    Request files without user's file key

.DESCRIPTION
    ### Description:  
Requests a list of missing file keys that may be generated by the current user.  

### Precondition:
User has a key pair.  
Only returns users that owns one of the following permissions: <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage download share</span>

### Postcondition:
None.

### Further Information:
Clients **SHOULD** regularly request missing file keys to provide access to files for other users.  
The returned list is ordered by priority (emergency passwords / rescue keys are returned first).
There is an enforced limit of **100** items per request.
A total value greater than limit signals that there are more entries but does not necessarily reflect the precise
number of total items.


.PARAMETER User_id
    User ID

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER File_id
    File ID

.PARAMETER Use_key
    Determines which key should be used (NEW)

.PARAMETER Offset
    Range offset

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Room_id
    Room ID

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.EXAMPLE
    PS C:\> Get-DracoonARNodeMissingfilekey -Connection $connection

    ### Description:  
Requests a list of missing file keys that may be generated by the current user.  

### Precondition:
User has a key pair.  
Only returns users that owns one of the following permissions: <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; read</span>, <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; manage download share</span>

### Postcondition:
None.

### Further Information:
Clients **SHOULD** regularly request missing file keys to provide access to files for other users.  
The returned list is ordered by priority (emergency passwords / rescue keys are returned first).
There is an enforced limit of **100** items per request.
A total value greater than limit signals that there are more entries but does not necessarily reflect the precise
number of total items.


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $User_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $File_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Use_key,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Room_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit
    )
    process {
        $__mapping = @{
            'User_id' = 'user_id'
            'Connection' = 'Connection'
            'File_id' = 'file_id'
            'Use_key' = 'use_key'
            'Offset' = 'offset'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Room_id' = 'room_id'
            'Limit' = 'limit'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('User_id','File_id','Use_key','Offset','Room_id','Limit') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'nodes/missingFileKeys'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}