function Get-DracoonARNodeSearch {
<#
.SYNOPSIS
    Search nodes

.DESCRIPTION
    ### Description:  
Provides a flat list of file system nodes (rooms, folders or files) of a given parent that are accessible by the current user.

### Precondition:
Authenticated user is allowed to <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128065; see</span> nodes (i.e. `isBrowsable = true`).

### Postcondition:
List of nodes is returned.

### Further Information:  
Output is limited to **500** entries.  
For more results please use filter criteria and paging (`offset` + `limit`).  
`EncryptionInfo` is **NOT** provided.  
Wildcard character is the asterisk character: `*`

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`type:eq:file|createdAt:ge:2015-01-01`  
Get nodes where type equals `file` **AND** file creation date is **>=** `2015-01-01`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `type` | Node type filter | `eq` | Node type equals value.<br>Multiple values are allowed and will be connected via logical disjunction (**OR**).<br>e.g. `type:eq:room:folder` | <ul><li>`room`</li><li>`folder`</li><li>`file`</li></ul> |
| `fileType` | File type filter (file extension) | `cn, eq` | File type contains / equals value. | `search String` |
| `classification` | Classification filter | `eq` | Classification equals value. | <ul><li>`1` - public</li><li>`2` - internal</li><li>`3` - confidential</li><li>`4` - strictly confidential</li></ul> |
| `createdBy` | Creator login filter | `cn, eq` | Creator login contains / equals value (`firstName` **OR** `lastName` **OR** `email` **OR** `username`). | `search String` |
| `createdById` | Creator ID filter | `eq` | Creator ID equals value. | `positive Integer  or -1 for external user` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `updatedBy` | Last modifier login filter | `cn, eq` | Last modifier login contains / equals value (`firstName` **OR** `lastName` **OR** `email` **OR** `username`). | `search String` |
| `updatedById` | Last modifier ID filter | `eq` | Modifier ID equals value. | `positive Integer or -1 for external user` |
| `updatedAt` | Last modification date filter | `ge, le` | Last modification date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `updatedAt:ge:2016-12-31`&#124;`updatedAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `expireAt` | Expiration date filter | `ge, le` | Expiration date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `expireAt:ge:2016-12-31`&#124;`expireAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `size` | Node size filter | `ge, le` | Node size is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `size:ge:5`&#124;`size:le:10` | `size in bytes` |
| `isFavorite` | Favorite filter | `eq` |  | `true or false` |
| `branchVersion` | Node branch version filter | `ge, le` | Branch version is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `branchVersion:ge:1423280937404`&#124;`branchVersion:le:1523280937404` | `version number` |
| `parentPath` | Parent path | `cn, eq` | Parent path contains / equals  value. | `search String` |
| `timestampCreation` | Creation timestamp filter | `ge, le` | Creation timestamp is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `timestampCreation:ge:2016-12-31T23:00:00.123`&#124;<br>`timestampCreation:le:2018-01-01T11:00:00.540` | `Date (yyyy-MM-dd)` |
| `timestampModification` | Modification timestamp filter | `ge, le` | Modification timestamp is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `timestampModification:ge:2016-12-31T23:00:00.123`&#124;<br>`timestampModification:le:2018-01-01T11:00:00.540` | `Date (yyyy-MM-dd)` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`name:desc`  
Sort by `name` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `name` | Node name |
| `createdAt` | Creation date |
| `createdBy` | Creator first name, last name |
| `updatedAt` | Last modification date |
| `updatedBy` | Last modifier first name, last name |
| `fileType` | File type (extension) |
| `classification` | Classification ID:<ul><li>1 - public</li><li>2 - internal</li><li>3 - confidential</li><li>4 - strictly confidential</li></ul> |
| `size` | Node size |
| `cntDeletedVersions` | Number of deleted versions of this file / folder (**NOT** recursive; for files and folders only) |
| `type` | Node type (room, folder, file) |
| `parentPath` | Parent path |
| `timestampCreation` | Creation timestamp |
| `timestampModification` | Modification timestamp |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`cntAdmins`</del> | Number of admins (for rooms only) |
| <del>`cntUsers`</del> | Number of users (for rooms only) |
| <del>`cntChildren`</del> | Number of direct children (**NOT** recursive; for rooms and folders only) |

</details>

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Filter
    Filter string

.PARAMETER Offset
    Range offset

.PARAMETER Parent_id
    Parent node ID.

Only rooms and folders can be parents.

Parent ID `0` or empty is the root node.

.PARAMETER Search_string
    Search string

.PARAMETER Limit
    Range limit.

Maximum 500.

 For more results please use paging (`offset` + `limit`).

.PARAMETER Sort
    Sort string

.PARAMETER XSdsDateFormat
    Date time format (cf. [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) & [leettime.de](http://leettime.de/))

.PARAMETER Depth_level
    * `0` - top level nodes only (default)

* `-1` - full tree

* `n` (any positive number) - include `n` levels starting from the current node

.EXAMPLE
    PS C:\> Get-DracoonARNodeSearch -Connection $connection -Search_string $search_string

    ### Description:  
Provides a flat list of file system nodes (rooms, folders or files) of a given parent that are accessible by the current user.

### Precondition:
Authenticated user is allowed to <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128065; see</span> nodes (i.e. `isBrowsable = true`).

### Postcondition:
List of nodes is returned.

### Further Information:  
Output is limited to **500** entries.  
For more results please use filter criteria and paging (`offset` + `limit`).  
`EncryptionInfo` is **NOT** provided.  
Wildcard character is the asterisk character: `*`

### Filtering:
All filter fields are connected via logical conjunction (**AND**)  
Filter string syntax: `FIELD_NAME:OPERATOR:VALUE[:VALUE...]`  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`type:eq:file|createdAt:ge:2015-01-01`  
Get nodes where type equals `file` **AND** file creation date is **>=** `2015-01-01`.

</details>

### Filtering options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Filter Description | `OPERATOR` | Operator Description | `VALUE` |
| :--- | :--- | :--- | :--- | :--- |
| `type` | Node type filter | `eq` | Node type equals value.<br>Multiple values are allowed and will be connected via logical disjunction (**OR**).<br>e.g. `type:eq:room:folder` | <ul><li>`room`</li><li>`folder`</li><li>`file`</li></ul> |
| `fileType` | File type filter (file extension) | `cn, eq` | File type contains / equals value. | `search String` |
| `classification` | Classification filter | `eq` | Classification equals value. | <ul><li>`1` - public</li><li>`2` - internal</li><li>`3` - confidential</li><li>`4` - strictly confidential</li></ul> |
| `createdBy` | Creator login filter | `cn, eq` | Creator login contains / equals value (`firstName` **OR** `lastName` **OR** `email` **OR** `username`). | `search String` |
| `createdById` | Creator ID filter | `eq` | Creator ID equals value. | `positive Integer  or -1 for external user` |
| `createdAt` | Creation date filter | `ge, le` | Creation date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `createdAt:ge:2016-12-31`&#124;`createdAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `updatedBy` | Last modifier login filter | `cn, eq` | Last modifier login contains / equals value (`firstName` **OR** `lastName` **OR** `email` **OR** `username`). | `search String` |
| `updatedById` | Last modifier ID filter | `eq` | Modifier ID equals value. | `positive Integer or -1 for external user` |
| `updatedAt` | Last modification date filter | `ge, le` | Last modification date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `updatedAt:ge:2016-12-31`&#124;`updatedAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `expireAt` | Expiration date filter | `ge, le` | Expiration date is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `expireAt:ge:2016-12-31`&#124;`expireAt:le:2018-01-01` | `Date (yyyy-MM-dd)` |
| `size` | Node size filter | `ge, le` | Node size is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `size:ge:5`&#124;`size:le:10` | `size in bytes` |
| `isFavorite` | Favorite filter | `eq` |  | `true or false` |
| `branchVersion` | Node branch version filter | `ge, le` | Branch version is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `branchVersion:ge:1423280937404`&#124;`branchVersion:le:1523280937404` | `version number` |
| `parentPath` | Parent path | `cn, eq` | Parent path contains / equals  value. | `search String` |
| `timestampCreation` | Creation timestamp filter | `ge, le` | Creation timestamp is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `timestampCreation:ge:2016-12-31T23:00:00.123`&#124;<br>`timestampCreation:le:2018-01-01T11:00:00.540` | `Date (yyyy-MM-dd)` |
| `timestampModification` | Modification timestamp filter | `ge, le` | Modification timestamp is greater / less equals than value.<br>Multiple operator values are allowed and will be connected via logical conjunction (**AND**).<br>e.g. `timestampModification:ge:2016-12-31T23:00:00.123`&#124;<br>`timestampModification:le:2018-01-01T11:00:00.540` | `Date (yyyy-MM-dd)` |

</details>

---

### Sorting:
Sort string syntax: `FIELD_NAME:ORDER`  
`ORDER` can be `asc` or `desc`.  
Multiple sort fields are **NOT** supported.  

<details style="padding-left: 10px">
<summary style="cursor: pointer; outline: none"><strong>Example</strong></summary>

`name:desc`  
Sort by `name` descending.

</details>

### Sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| `name` | Node name |
| `createdAt` | Creation date |
| `createdBy` | Creator first name, last name |
| `updatedAt` | Last modification date |
| `updatedBy` | Last modifier first name, last name |
| `fileType` | File type (extension) |
| `classification` | Classification ID:<ul><li>1 - public</li><li>2 - internal</li><li>3 - confidential</li><li>4 - strictly confidential</li></ul> |
| `size` | Node size |
| `cntDeletedVersions` | Number of deleted versions of this file / folder (**NOT** recursive; for files and folders only) |
| `type` | Node type (room, folder, file) |
| `parentPath` | Parent path |
| `timestampCreation` | Creation timestamp |
| `timestampModification` | Modification timestamp |

</details>

### Deprecated sorting options:
<details style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| `FIELD_NAME` | Description |
| :--- | :--- |
| <del>`cntAdmins`</del> | Number of admins (for rooms only) |
| <del>`cntUsers`</del> | Number of users (for rooms only) |
| <del>`cntChildren`</del> | Number of direct children (**NOT** recursive; for rooms and folders only) |

</details>

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Filter,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Offset,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Parent_id,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Search_string,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Limit,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Sort,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $XSdsDateFormat,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Depth_level
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
            'Filter' = 'filter'
            'Offset' = 'offset'
            'Parent_id' = 'parent_id'
            'Search_string' = 'search_string'
            'Limit' = 'limit'
            'Sort' = 'sort'
            'XSdsDateFormat' = 'X-Sds-Date-Format'
            'Depth_level' = 'depth_level'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Filter','Offset','Parent_id','Search_string','Limit','Sort','Depth_level') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken','XSdsDateFormat') -Mapping $__mapping
        $__path = 'nodes/search'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}