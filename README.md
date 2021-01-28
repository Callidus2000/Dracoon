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

This is an example of how to list things you need to use the software and how to install them.
* psframework - Open a powershell and install it from the gallery:
  ```powershell
  Install-Module psframework
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Callidus2000/Dracoon.git
   ```
2. Install the current version
   ```powershell
   .\Install.ps1
   ```

As soon as the module is published to the gallery it will be documented here.


<!-- USAGE EXAMPLES -->
## Usage

The module is a wrapper for the Dracoon API. As you have to authenticate with OAuth2.0 it is neccessary to create a client application within the admin web-page. For this
* Go to _System Settings_ / _Apps_ in the navigation bar
* Click on the _Add app_ button
* Enter an application name (e.g. "Powershell Scripting")
* enable all 4 checkboxes (authorization code:implicit:password:refresh token)
* Copy the _Client ID_ and the _Client Secret_. Both will be referenced as `$ClientID` and `$ClientSecret`.


<!-- ROADMAP -->
## Roadmap
New features will be added if any of my scripts need it ;-)

See the [open issues](https://github.com/Callidus2000/Dracoon/issues) for a list of proposed features (and known issues).

If you need a special function feel free to contribute to the project.

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### API documentation
The API is very well documented with swagger, documentation can either be found at https://dracoon.team/api/ or (for your custom installation) at https://yourdomain.com/api/.

### Working with the layout
This module was created with the help of [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment) and follows the default folder layout. Therefor the default rules apply:
- Don't touch the psm1 file
- Place functions you export in `functions/` (can have subfolders)
- Place private/internal functions invisible to the user in `internal/functions` (can have subfolders)
- Don't add code directly to the `postimport.ps1` or `preimport.ps1`.
  Those files are designed to import other files only.
- When adding files & folders, make sure they are covered by either `postimport.ps1` or `preimport.ps1`.
  This adds them to both the import and the build sequence.



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
[contributors-shield]: https://img.shields.io/github/contributors/Callidus2000/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/Callidus2000/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Callidus2000/repo.svg?style=for-the-badge
[forks-url]: https://github.com/Callidus2000/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/Callidus2000/repo.svg?style=for-the-badge
[stars-url]: https://github.com/Callidus2000/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/Callidus2000/repo.svg?style=for-the-badge
[issues-url]: https://github.com/Callidus2000/repo/issues
[license-shield]: https://img.shields.io/github/license/Callidus2000/repo.svg?style=for-the-badge
[license-url]: https://github.com/Callidus2000/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/Callidus2000

