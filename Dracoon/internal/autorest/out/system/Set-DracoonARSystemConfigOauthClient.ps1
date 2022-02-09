function Set-DracoonARSystemConfigOauthClient {
<#
.SYNOPSIS
    Create OAuth client

.DESCRIPTION
    ### Description:
Create a new OAuth client.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
New OAuth client created.

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

Allowed characters for client ID are: `[a-zA-Z0-9_-]`

If grant types `authorization_code` or `implicit` are used, a
redirect URI **MUST** be provided!

Default access token validity: **8 hours**  
Default refresh token validity: **30 days**
Default approval validity: **½ year**

.PARAMETER Connection
    Object of Class ARAHConnection, stores the authentication Token and the API Base-URL

.PARAMETER XSdsAuthToken
    Authentication token

.EXAMPLE
    PS C:\> Set-DracoonARSystemConfigOauthClient -Connection $connection

    ### Description:
Create a new OAuth client.

### Precondition:
Right <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128275; change global config</span> and
role <span style='padding: 3px; background-color: #F6F7F8; border: 1px solid #000; border-radius: 5px; display: inline;'>&#128100; Config Manager</span> of the Provider Customer required.

### Postcondition:
New OAuth client created.

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

Allowed characters for client ID are: `[a-zA-Z0-9_-]`

If grant types `authorization_code` or `implicit` are used, a
redirect URI **MUST** be provided!

Default access token validity: **8 hours**  
Default refresh token validity: **30 days**
Default approval validity: **½ year**

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
        $__path = 'system/config/oauth/clients'
        Invoke-DracoonAPI -Path $__path -Method post -Body $__body -Query $__query -Header $__header -Connection $Connection
    }
}