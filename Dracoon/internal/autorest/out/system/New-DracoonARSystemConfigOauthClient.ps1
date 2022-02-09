function New-DracoonARSystemConfigOauthClient {
<#
.SYNOPSIS
    Update OAuth client

.DESCRIPTION
    ### Description:  
Update an existing OAuth client.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
OAuth client updated.

### Further Information:  
Client secret **MUST** have:  
* at least 12 characters, at most 32 characters  
* only lower case characters, upper case characters and digits  
* at least 1 lower case character, 1 upper case character and 1 digit  

The client secret is optional and will be generated if it is left empty.  

Valid grant types are:  
* `authorization_code`  
* `implicit`  
* `password`  
* `client_credentials`  
* `refresh_token`  

Grant type `client_credentials` is currently **NOT** permitted!

If grant types `authorization_code` or `implicit` are used, a
redirect URI **MUST** be provided!


.PARAMETER Client_id
    OAuth client ID

.PARAMETER XSdsAuthToken
    Authentication token

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.EXAMPLE
    PS C:\> New-DracoonARSystemConfigOauthClient -Client_id $client_id -Connection $connection

    ### Description:  
Update an existing OAuth client.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
OAuth client updated.

### Further Information:  
Client secret **MUST** have:  
* at least 12 characters, at most 32 characters  
* only lower case characters, upper case characters and digits  
* at least 1 lower case character, 1 upper case character and 1 digit  

The client secret is optional and will be generated if it is left empty.  

Valid grant types are:  
* `authorization_code`  
* `implicit`  
* `password`  
* `client_credentials`  
* `refresh_token`  

Grant type `client_credentials` is currently **NOT** permitted!

If grant types `authorization_code` or `implicit` are used, a
redirect URI **MUST** be provided!


.LINK
    <unknown>
#>
    [CmdletBinding(DefaultParameterSetName = 'default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $Client_id,

        [Parameter(ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [string]
        $XSdsAuthToken,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'default')]
        [object]
        $Connection
    )
    process {
        $__mapping = @{
            'XSdsAuthToken' = 'X-Sds-Auth-Token'
            'Connection' = 'Connection'
        }
        $__body = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__query = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @() -Mapping $__mapping
        $__header = $PSBoundParameters | ConvertTo-DracoonARHashtable -Include @('XSdsAuthToken') -Mapping $__mapping
        $__path = 'system/config/oauth/clients/{client_id}' -Replace '{client_id}',$Client_id
        Invoke-DracoonAPI -Path $__path -Method put -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}