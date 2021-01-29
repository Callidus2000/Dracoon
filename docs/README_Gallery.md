﻿#  Dracoon Powershell Module

This Powershell Module is a wrapper for the API of Dracoon. Dracoon is a
solution for a secure file exchange and can be used as a cloud service or OnPremise for internal uses. Further information about Dracoon can be found at [https://www.dracoon.com/](https://www.dracoon.com/).
## Detailed Information for this Module
- [Project Homepage @github](https://github.com/Callidus2000/Dracoon)
- [Report Bug](https://github.com/Callidus2000/Dracoon/issues)
- [Request Feature](https://github.com/Callidus2000/Dracoon/issues)

## Installation

The releases are published in the Powershell Gallery, therefor it is quite simple:
  ```powershell
  Install-Module Dracoon -Force -AllowClobber
  ```
The `AllowClobber` option is currently neccessary because of an issue in the current PowerShellGet module. Hopefully it will not be needed in the future any more.

## Usage

The module is a wrapper for the Dracoon API. As you have to authenticate with OAuth2.0 it is neccessary to create a client application within the admin web-page. For this
* Go to _System Settings_ / _Apps_ in the navigation bar
* Click on the _Add app_ button
* Enter an application name (e.g. "Powershell Scripting")
* enable all 4 checkboxes (authorization code:implicit:password:refresh token)
* Copy the _Client ID_ and the _Client Secret_. Both will be referenced as `$ClientID` and `$ClientSecret`.

Now it's time to open the powershell. Prepare the basic variables:
```powershell
$cred=Get-Credential -Message "Dracoon"
$clientId="YOU JUST CREATED IT ;-)"
$clientSecret="THIS ALSO"
$url="dracoon.mydomain.com"
```
From here you have multiple possibilities to connect to your server and store the connection for further usage:
#### Direct auth with /auth/login (**Deprecated**)
If you are running an older version it maybe possible to login directly. But this option is deprecated and [will be removed in every installation in the future](https://blog.dracoon.com/en/goodbye-x-sds-auth-token-hello-oauth-2.0)
```powershell
$connection=Connect-Dracoon -Url $url -Credential $cred
```
#### Via OAuth access token
```powershell
# Generate accesstoken
$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -Credential $cred -TokenType access
# Login with created access token
$connection=Connect-Dracoon -Url $url -AccessToken $accessToken
```
#### Via OAuth refresh token
```powershell
# Create a refresh token
$refreshToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Credential $cred -url $url -TokenType refresh

# Connect directly with the refresh token
$connection=Connect-Dracoon -ClientID $clientId -ClientSecret $clientSecret -url $url -RefreshToken $refreshToken

# Second option: Create an access token from the refreh token and login with the access token.
$accessToken=Request-DracoonOAuthToken -ClientID $clientId -ClientSecret $clientSecret -Url $url -RefreshToken $refreshToken
$connection=Connect-Dracoon -Url $url -AccessToken $accessToken
```

Now we are connected to your server: What can we do? 
```powershell
# Query all Users and display the data in a table
Get-DracoonUser -Connection $connection |ft

# Query a specific user (you have to know the login)
Get-DracoonUser -Connection $connection -Filter 'login:cn:DonaldDuck'

#Find all locked accounts and remove the users (Luckily it supports WhatIf)
Get-DracoonUser -Connection $connection -Filter 'isLocked:eq:true' |Remove-DracoonUser -connection $connection -WhatIf 
```
If you need an overview of the existing commands use 
```powershell
# List available commands
Get-Command -Module Dracoon
#Get-Help for a specific command
Get-Help -Detailed Get-DracoonUser
```
everything else is documented in the module itself.

### Tab completion
Are you tired of typing the URL of your Server? Do you have multiple instances? Add the possible URLs to the Tab Completer:
```powershell
Add-DracoonURL "myserver.com"
```
Now give it a try and hit `TAB` after any `-Url` Parameter. You can now choose between all previously saved server addresses.

The same mechanism kicks in for the '-Filter' parameters:
```powershell
Get-DracoonUser -Connection $connection -Filter [TAB]
effectiveRoles:eq:[true or false]  firstName:cn:[search String]
isLocked:eq:[true or false]        lastName:cn:[search String]
login:cn:[search String]
```


## License

Distributed under the GNU GENERAL PUBLIC LICENSE version 3. See [LICENSE](https://raw.githubusercontent.com/Callidus2000/Dracoon/master/LICENSE) for more information.

## Contact

Project Link: [https://github.com/Callidus2000/Dracoon](https://github.com/Callidus2000/Dracoon)
