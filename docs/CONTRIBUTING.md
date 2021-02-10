# Contributing to this repository

No need for duplicating basic KnowHow about contributing, I think that everything is [well documented by github ;-)](https://github.com/github/docs/blob/main/CONTRIBUTING.md).

A big welcome and thank you for considering contributing to this repository! Besides the named basics getting an overview of the internal logic is quite helpful if you want to contribute. Let's get started..

## Missing a functionality?

If you are missing a function in this module:
* Identify the corresponding API from the [Swagger documentation](#Swagger-documentation)
* Take a look at [Working with the layout](#working-with-the-layout)
* Add a new public function under `\Dracoon\functions`
  * One function per file
  * Filename relates to the function name
  * Add the function to `\Dracoon\Dracoon.psd1` under `FunctionsToExport`
* Make use of [API Proxy Invoke-DracoonAPI](#api-proxy-invoke-dracoonapi) to access the API - it takes the stress out of coping with default problem
* Add new [Pester tests](#pester-tests) for the new function
* The module has currently some [limitations](#limitations) - either live with them or fix them by contributing.

## API First

This Powershell Module is a wrapper for the API of Dracoon. Therefor the module cannot perform anything the API can't. Luckily Dracoon follows the 'API-First' approach: if there is functionality then the API exists before the function.

### Swagger documentation

The API documentation can either be found at https://dracoon.team/api/ or (for your custom installation) at https://yourdomain.com/api/.

### Working with the layout
This module was created with the help of [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment) and follows the default folder layout. Therefor the default rules apply:
- Don't touch the psm1 file
- Place functions you export in `functions/` (can have subfolders)
- Place private/internal functions invisible to the user in `internal/functions` (can have subfolders)
- Don't add code directly to the `postimport.ps1` or `preimport.ps1`.
  Those files are designed to import other files only.
- When adding files & folders, make sure they are covered by either `postimport.ps1` or `preimport.ps1`.
  This adds them to both the import and the build sequence.

## API Proxy Invoke-DracoonAPI

If you take a look at (most) public functions you will recognize the use of `Invoke-DracoonAPI`. This is a generic access function for any Dracoon API.

### Why not use Invoke-RestMethod/Invoke-WebRequest?

Of course it would be possible to use the native Invoke-RestMethod or Invoke-WebRequest, and this is done. But only within `Invoke-DracoonAPI` (as it is a wrapper for `Invoke-RestMethod`) and within `Request-DracoonOAuthToken` (as this is needed for authentication which is a prerequisite for using `Invoke-DracoonAPI`).

Every API call basically performs at least the following steps:
* Build the URI to access, including necessary URI parameters
* Build the headers (e.g. for authentication)
* Build the JSON body
* `Invoke-RestMethod`
* Return the response

That's the quick and easy way for getting started. But for robust code there is more:
* Filter `$null` values from the parameters as for example
  * while creating a new folder you can add a note, but you don't have to
  * if you don't need an expiration date you still have to provide one
* Exception handling
  * Does the API throw an exception? Get the details to the logging and rethrow it or not
* Paging
  * Many APIs work with `limit` and `offset` parameters to request only partial information.
  * This is good for performance in user driven apps like the webUI
  * In scripts you perform mass operations in most cases
  * `Invoke-RestMethod` can get all data pages and return all of the data

Just take a look at existing functions, it's hopefully self explaining. Otherwise raise an issue for asking about details.

## Pester tests
The module does use pester for general and functional tests. The general tests are provided by [PSModuleDevelopment](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment) and perform checks like *"is the help well written and complete"*. This results in more than 3500 automatic tests over all.

If you create a new function please provide a corresponding pester test within the `\Dracoon\tests\functions` directory. A pester tests should
* Setup the test environment in a clean state, e.g.
  * Create a new pester data room
* Teardown/remove the test environment as a last step, e.g.
  * Delete created datarooms

If you have only created a Getter function without the corresponding Create/Remove counterparts you will not be able to perform this clean testing. If this happens please either provide the additional functions or [create an issue](https://github.com/Callidus2000/Dracoon/issues) at the GitHub project page. An example is currently [Issue 4 - Implement pester tests for Get-DracoonAuthConfigAD](https://github.com/Callidus2000/Dracoon/issues/4)


## Limitations
* Not everything is being tested with [Pester tests](#pester-tests) - Feel free to add them for existing functions
* The module only works for unencrypted Datarooms. Simple reason: Our instances do not use the ['Client-side Encryption'](https://support.dracoon.com/hc/en-us/articles/360000986345-Whitepaper-Client-side-Encryption-) feature. If your instance does provide it feel free to add the feature to the module.