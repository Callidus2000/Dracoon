<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GPLv3 License][license-shield]][license-url]


<br />
<p align="center">
<!-- PROJECT LOGO
  <a href="https://github.com/Callidus2000/Dracoon">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
-->

  <h3 align="center">Dracoon Powershell Module</h3>

  <p align="center">
    This Powershell Module is a wrapper for the API of <a href="https://www.dracoon.com/">Dracoon</a>
    <br />
    <a href="https://github.com/Callidus2000/Dracoon"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/Callidus2000/Dracoon/issues">Report Bug</a>
    ·
    <a href="https://github.com/Callidus2000/Dracoon/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This Powershell Module is a wrapper for the API of Dracoon. Dracoon is a
solution for a secure file exchange and can be used as a cloud service or OnPremise for internal uses. Further information about Dracoon can be found at https://www.dracoon.com/.

The API is very well documented with swagger, documentation can either be found at https://dracoon.team/api/ or (for your custom installation) at https://yourdomain.com/api/.


### Built With

* [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment)
* [psframework](https://github.com/PowershellFrameworkCollective/psframework)



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

All prerequisites will be installed automatically.

### Installation

The releases are published in the Powershell Gallery, therefor it is quite simple:
  ```powershell
  Install-Module Dracoon -Force -AllowClobber
  ```
The `AllowClobber` option is currently neccessary because of an issue in the current PowerShellGet module. Hopefully it will not be needed in the future any more.

<!-- USAGE EXAMPLES -->
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

<!-- ROADMAP -->
## Roadmap
New features will be added if any of my scripts need it ;-)

See the [open issues](https://github.com/Callidus2000/Dracoon/issues) for a list of proposed features (and known issues).

If you need a special function feel free to contribute to the project.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. For more details please take a look at the [CONTRIBUTE](docs/CONTRIBUTING.md#Contributing-to-this-repository) document

Short stop:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Limitations
* The module only works for unencrypted Datarooms. Simple reason: Our instances do not use the ['Client-side Encryption'](https://support.dracoon.com/hc/en-us/articles/360000986345-Whitepaper-Client-side-Encryption-) feature. If your instance does provide it feel free to add the feature to the module.

<!-- LICENSE -->
## License

Distributed under the GNU GENERAL PUBLIC LICENSE version 3. See `LICENSE.md` for more information.



<!-- CONTACT -->
## Contact


Project Link: [https://github.com/Callidus2000/Dracoon](https://github.com/Callidus2000/Dracoon)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [Friedrich Weinmann](https://github.com/FriedrichWeinmann) for his marvelous [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment) and [psframework](https://github.com/PowershellFrameworkCollective/psframework)





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Callidus2000/Dracoon.svg?style=for-the-badge
[contributors-url]: https://github.com/Callidus2000/Dracoon/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Callidus2000/Dracoon.svg?style=for-the-badge
[forks-url]: https://github.com/Callidus2000/Dracoon/network/members
[stars-shield]: https://img.shields.io/github/stars/Callidus2000/Dracoon.svg?style=for-the-badge
[stars-url]: https://github.com/Callidus2000/Dracoon/stargazers
[issues-shield]: https://img.shields.io/github/issues/Callidus2000/Dracoon.svg?style=for-the-badge
[issues-url]: https://github.com/Callidus2000/Dracoon/issues
[license-shield]: https://img.shields.io/github/license/Callidus2000/Dracoon.svg?style=for-the-badge
[license-url]: https://github.com/Callidus2000/Dracoon/blob/master/LICENSE

