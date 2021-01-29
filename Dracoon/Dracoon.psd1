@{
	# Script module or binary module file associated with this manifest
	RootModule = 'Dracoon.psm1'

	# Version number of this module.
	ModuleVersion = '1.2.1'

	# ID used to uniquely identify this module
	GUID = 'c4a0b04e-f2c8-405a-b7f1-6202575649a6'

	# Author of this module
	Author = 'Sascha Spiekermann'

	# Company or vendor of this module
	# CompanyName = 'MyCompany'

	# Copyright statement for this module
	Copyright = 'Copyright (c) 2020 Sascha Spiekermann'

	# Description of the functionality provided by this module
	Description = 'Commands for interacting with the API of Dracoon server.'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.0'

	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules = @(
		@{ ModuleName='PSFramework'; ModuleVersion='1.4.149' }
	)

	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies = @('System.Web')

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\Dracoon.Types.ps1xml')

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\Dracoon.Format.ps1xml')

	# Functions to export from this module
	FunctionsToExport  = @(
		'Connect-Dracoon'
		'Get-DracoonAuditDataroom'
		'Invoke-DracoonAPI'
		'Request-DracoonOAuthToken'
		'Get-DracoonUser'
		'New-DracoonDataroom'
		'Get-DracoonNode'
		'Remove-DracoonNode'
		'Get-DracoonCurrentAccount'
		'New-DracoonUser'
		'Get-DracoonAuthConfigAD'
		'Remove-DracoonUser'
		'Get-DracoonGroup'
		'Set-DracoonUserAttribute'
		'Get-DracoonUserAttribute'
		'Get-DracoonRoomAcl'
		'Set-DracoonRoomAcl'
		'Convert-DracoonGetSetRoomAcl'
		'Get-DracoonLastAdminRoom'
		'Search-DracoonNode'
		'Test-DracoonConnection'
		'Add-DracoonUrl'
		'Set-DracoonUrl'
	)

	# Cmdlets to export from this module
	CmdletsToExport = ''

	# Variables to export from this module
	VariablesToExport = ''

	# Aliases to export from this module
	AliasesToExport = ''

	# List of all modules packaged with this module
	ModuleList = @()

	# List of all files packaged with this module
	FileList = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{

		#Support for PowerShellGet galleries.
		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			# Tags = @('')


			# A URL to the license for this module.
			LicenseUri = 'https://github.com/Callidus2000/Dracoon/blob/master/LICENSE'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/Callidus2000/Dracoon/'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable
}