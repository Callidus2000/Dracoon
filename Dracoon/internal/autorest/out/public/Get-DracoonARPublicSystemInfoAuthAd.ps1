function Get-DracoonARPublicSystemInfoAuthAd {
<#
.SYNOPSIS
    Request Active Directory authentication information

.DESCRIPTION
    ### Description:  
Provides information about Active Directory authentication options.

### Precondition:
None.

### Postcondition:
Active Directory authentication options information is returned.

### Further Information:
None.

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER Is_global_available
    Show only global available items

.EXAMPLE
    PS C:\> Get-DracoonARPublicSystemInfoAuthAd -Connection $connection

    ### Description:  
Provides information about Active Directory authentication options.

### Precondition:
None.

### Postcondition:
Active Directory authentication options information is returned.

### Further Information:
None.

.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [boolean]
        $Is_global_available
    )
    process {
        $__mapping = @{
            'Connection' = 'Connection'
            'Is_global_available' = 'is_global_available'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('Is_global_available') -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__path = 'public/system/info/auth/ad'
        Invoke-DracoonAPI -Path $__path -Method get -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}