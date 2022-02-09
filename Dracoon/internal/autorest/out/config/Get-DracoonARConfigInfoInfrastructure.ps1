function Get-DracoonARConfigInfoInfrastructure {
<#
.SYNOPSIS
    Request infrastructure properties

.DESCRIPTION
    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.6.0</h3>

### Description:  
Returns a list of read-only infrastructure properties.  

### Precondition:
Authenticated user.

### Postcondition:
List of infrastructure properties is returned.

### Further Information:
Source: `core-service.properties`

### Read-only infrastructure properties:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `smsConfigEnabled` | Determines whether sending of share passwords via SMS is **system-wide** enabled. | `true or false` |
| `mediaServerConfigEnabled` | Determines whether media server is **system-wide** enabled. | `true or false` |
| `s3DefaultRegion` | Suggested S3 region | `Region name` |
| `s3EnforceDirectUpload` | Enforce direct upload to S3 | `true or false` |
| `isDracoonCloud` | Determines if the **DRACOON Core** is deployed in the cloud environment | `true or false` |
| `tenantUuid` | Current tenant UUID | `UUID` |

</details>


.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Get-DracoonARConfigInfoInfrastructure -Connection $connection

    <h3 style='padding: 5px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px; display: table-cell;'>&#128640; Since v4.6.0</h3>

### Description:  
Returns a list of read-only infrastructure properties.  

### Precondition:
Authenticated user.

### Postcondition:
List of infrastructure properties is returned.

### Further Information:
Source: `core-service.properties`

### Read-only infrastructure properties:
<details open style="padding: 10px; background-color: #F6F7F8; border: 1px solid #AAA; border-radius: 5px;">
<summary style="cursor: pointer; outline: none"><strong>Expand</strong></summary>

| Setting | Description | Value |
| :--- | :--- | :--- |
| `smsConfigEnabled` | Determines whether sending of share passwords via SMS is **system-wide** enabled. | `true or false` |
| `mediaServerConfigEnabled` | Determines whether media server is **system-wide** enabled. | `true or false` |
| `s3DefaultRegion` | Suggested S3 region | `Region name` |
| `s3EnforceDirectUpload` | Enforce direct upload to S3 | `true or false` |
| `isDracoonCloud` | Determines if the **DRACOON Core** is deployed in the cloud environment | `true or false` |
| `tenantUuid` | Current tenant UUID | `UUID` |

</details>


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'config/info/infrastructure'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}