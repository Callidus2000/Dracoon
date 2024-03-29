﻿@{
	# Script module or binary module file associated with this manifest
	RootModule         = 'Dracoon.psm1'

	# Version number of this module.
	ModuleVersion      = '1.5.2'

	# ID used to uniquely identify this module
	GUID               = 'c4a0b04e-f2c8-405a-b7f1-6202575649a6'

	# Author of this module
	Author             = 'Sascha Spiekermann'

	# Company or vendor of this module
	# CompanyName = 'MyCompany'

	# Copyright statement for this module
	Copyright          = 'Copyright (c) 2020 Sascha Spiekermann'

	# Description of the functionality provided by this module
	Description        = 'Commands for interacting with the API of Dracoon server.'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion  = '5.0'

	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules    = @(
		@{ ModuleName = 'PSFramework'; ModuleVersion = '1.6.214' }
		@{ ModuleName = 'ARAH'; ModuleVersion = '1.3.2' }
	)

	# Assemblies that must be loaded prior to importing this module
	RequiredAssemblies = @('System.Web')

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\Dracoon.Types.ps1xml')

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\Dracoon.Format.ps1xml')

	# Functions to export from this module
	FunctionsToExport  = @(
		'Add-DracoonUrl'
		'Connect-Dracoon'
		'Convert-DracoonGetSetRoomAcl'
		'Disable-DracoonAutoRest'
		'Enable-DracoonAutoRest'
		'Get-DracoonAuditDataroom'
		'Get-DracoonAuthConfigAD'
		'Get-DracoonCurrentAccount'
		'Get-DracoonGroup'
		'Get-DracoonLastAdminRoom'
		'Get-DracoonAPILog'
		'Get-DracoonNode'
		'Get-DracoonNodeAsZip'
		'Get-DracoonRoomAcl'
		'Get-DracoonUser'
		'Get-DracoonUserAttribute'
		'Invoke-DracoonAPI'
		'New-DracoonDataroom'
		'New-DracoonDownloadShare'
		'New-DracoonFolder'
		'New-DracoonUser'
		'Publish-DracoonFile'
		'Remove-DracoonNode'
		'Remove-DracoonUser'
		'Request-DracoonOAuthToken'
		'Search-DracoonNode'
		'Send-DracoonDownloadShareMail'
		'Set-DracoonRoomAcl'
		'Set-DracoonUrl'
		'Set-DracoonUserAttribute'
		'Test-DracoonConnection'
		'Connect-DracoonProvisioning'
		'Get-DracoonProvCustomer'
		'Get-DracoonARAuthOpenidLogin'
		'Get-DracoonARAuthOpenidResource'
		'Get-DracoonARAuthPing'
		'Get-DracoonARAuthReset_Password'
		'New-DracoonARAuthReset_Password'
		'Set-DracoonARAuthLogin'
		'Set-DracoonARAuthOpenidLogin'
		'Set-DracoonARAuthRecover_Username'
		'Set-DracoonARAuthReset_Password'
		'Get-DracoonARConfigInfoDefault'
		'Get-DracoonARConfigInfoGeneral'
		'Get-DracoonARConfigInfoInfrastructure'
		'Get-DracoonARConfigInfoLicense'
		'Get-DracoonARConfigInfoNotificationChannel'
		'Get-DracoonARConfigInfoPolicieAlgorithm'
		'Get-DracoonARConfigInfoPoliciePassword'
		'Get-DracoonARConfigInfoS3_Tag'
		'Get-DracoonARConfigSetting'
		'New-DracoonARConfigSetting'
		'Get-DracoonARDownload'
		'Get-DracoonARDownloadAvatar'
		'Get-DracoonARDownloadZip'
		'Invoke-DracoonARDownload'
		'Get-DracoonAREventlogAuditNode'
		'Get-DracoonAREventlogEvent'
		'Get-DracoonAREventlogOperation'
		'Get-DracoonARGroup'
		'Get-DracoonARGroupLast_Admin_Room'
		'Get-DracoonARGroupRole'
		'Get-DracoonARGroupRoom'
		'Get-DracoonARGroupUser'
		'New-DracoonARGroup'
		'Remove-DracoonARGroup'
		'Remove-DracoonARGroupUser'
		'Set-DracoonARGroup'
		'Set-DracoonARGroupUser'
		'Get-DracoonARNode'
		'Get-DracoonARNodeComment'
		'Get-DracoonARNodeDeleted_Node'
		'Get-DracoonARNodeDeleted_NodeVersion'
		'Get-DracoonARNodeFileData_Room_File_Key'
		'Get-DracoonARNodeFileData_Space_File_Key'
		'Get-DracoonARNodeFileDownload'
		'Get-DracoonARNodeFileUpload'
		'Get-DracoonARNodeFileUser_File_Key'
		'Get-DracoonARNodeMissingfilekey'
		'Get-DracoonARNodeParent'
		'Get-DracoonARNodeRoomActivities_Log'
		'Get-DracoonARNodeRoomEvent'
		'Get-DracoonARNodeRoomGroup'
		'Get-DracoonARNodeRoomKeypair'
		'Get-DracoonARNodeRoomPending'
		'Get-DracoonARNodeRoomS3_Tag'
		'Get-DracoonARNodeRoomUser'
		'Get-DracoonARNodeRoomWebhook'
		'Get-DracoonARNodeSearch'
		'Invoke-DracoonARNodeFileDownload'
		'New-DracoonARNodeComment'
		'New-DracoonARNodeFavorite'
		'New-DracoonARNodeFile'
		'New-DracoonARNodeFileUpload'
		'New-DracoonARNodeFileUploadS3'
		'New-DracoonARNodeFolder'
		'New-DracoonARNodeRoom'
		'New-DracoonARNodeRoomConfig'
		'New-DracoonARNodeRoomEncrypt'
		'New-DracoonARNodeRoomGroup'
		'New-DracoonARNodeRoomPending'
		'New-DracoonARNodeRoomUser'
		'New-DracoonARNodeRoomWebhook'
		'Remove-DracoonARNode'
		'Remove-DracoonARNodeComment'
		'Remove-DracoonARNodeDeleted_Node'
		'Remove-DracoonARNodeFavorite'
		'Remove-DracoonARNodeFileUpload'
		'Remove-DracoonARNodeRoomGroup'
		'Remove-DracoonARNodeRoomKeypair'
		'Remove-DracoonARNodeRoomUser'

		#region AutoGenerated Funktions
		# List can be gerated by Get-ChildItem "$ModuleRoot\internal\autorest\out" -Filter "*.ps1" -Recurse |Select-Object -ExpandProperty basename|wrap "'" "'"|Set-Clipboard
		'Set-DracoonARNodeComment'
		'Set-DracoonARNodeCopy_To'
		'Set-DracoonARNodeDeleted_NodeActionRestore'
		'Set-DracoonARNodeFavorite'
		'Set-DracoonARNodeFileDownload'
		'Set-DracoonARNodeFileKey'
		'Set-DracoonARNodeFileUpload'
		'Set-DracoonARNodeFileUploadS3_Url'
		'Set-DracoonARNodeFolder'
		'Set-DracoonARNodeMove_To'
		'Set-DracoonARNodeRoom'
		'Set-DracoonARNodeRoomKeypair'
		'Set-DracoonARNodeRoomS3_Tag'
		'Set-DracoonARNodeZip'
		'Set-DracoonARNodeZipDownload'
		'Get-DracoonARProvisioningCheck_License'
		'Get-DracoonARProvisioningCustomer'
		'Get-DracoonARProvisioningCustomerCustomerattribute'
		'Get-DracoonARProvisioningCustomerUser'
		'Get-DracoonARProvisioningWebhook'
		'Get-DracoonARProvisioningWebhookEvent_Type'
		'New-DracoonARProvisioningCustomer'
		'New-DracoonARProvisioningCustomerCustomerattribute'
		'New-DracoonARProvisioningWebhook'
		'Remove-DracoonARProvisioningCustomer'
		'Remove-DracoonARProvisioningCustomerCustomerattribute'
		'Remove-DracoonARProvisioningWebhook'
		'Set-DracoonARProvisioningCustomer'
		'Set-DracoonARProvisioningCustomerCustomerattribute'
		'Set-DracoonARProvisioningWebhook'
		'Set-DracoonARProvisioningWebhookReset_Lifetime'
		'Get-DracoonARPublicShareDownload'
		'Get-DracoonARPublicShareUpload'
		'Get-DracoonARPublicSoftwareThird_Party_Dependencie'
		'Get-DracoonARPublicSoftwareVersion'
		'Get-DracoonARPublicSystemInfo'
		'Get-DracoonARPublicSystemInfoAuthAd'
		'Get-DracoonARPublicSystemInfoAuthOpenid'
		'Get-DracoonARPublicSystemInfoLicense'
		'Get-DracoonARPublicTime'
		'Invoke-DracoonARPublicShareDownload'
		'New-DracoonARPublicShareUpload'
		'New-DracoonARPublicShareUploadS3'
		'Remove-DracoonARPublicShareUpload'
		'Set-DracoonARPublicShareDownload'
		'Set-DracoonARPublicShareUpload'
		'Set-DracoonARPublicShareUploadS3_Url'
		'Get-DracoonARResourceUserAvatar'
		'Get-DracoonARResourceUserNotificationScope'
		'Get-DracoonARRole'
		'Get-DracoonARRoleGroup'
		'Get-DracoonARRoleUser'
		'Remove-DracoonARRoleGroup'
		'Remove-DracoonARRoleUser'
		'Set-DracoonARRoleGroup'
		'Set-DracoonARRoleUser'
		'Get-DracoonARSetting'
		'Get-DracoonARSettingKeypair'
		'Get-DracoonARSettingNotificationChannel'
		'Get-DracoonARSettingWebhook'
		'Get-DracoonARSettingWebhookEvent_Type'
		'New-DracoonARSetting'
		'New-DracoonARSettingNotificationChannel'
		'New-DracoonARSettingWebhook'
		'Remove-DracoonARSettingKeypair'
		'Remove-DracoonARSettingWebhook'
		'Set-DracoonARSettingKeypair'
		'Set-DracoonARSettingWebhook'
		'Set-DracoonARSettingWebhookReset_Lifetime'
		'Get-DracoonARShareDownload'
		'Get-DracoonARShareDownloadQr'
		'Get-DracoonARShareUpload'
		'Get-DracoonARShareUploadQr'
		'New-DracoonARShareDownload'
		'New-DracoonARShareUpload'
		'Remove-DracoonARShareDownload'
		'Remove-DracoonARShareUpload'
		'Set-DracoonARShareDownload'
		'Set-DracoonARShareDownloadEmail'
		'Set-DracoonARShareUpload'
		'Set-DracoonARShareUploadEmail'
		'Get-DracoonARSyslogAuditNode'
		'Get-DracoonARSyslogEvent'
		'Get-DracoonARSyslogOperation'
		'Get-DracoonARSystemConfigAuthAd'
		'Get-DracoonARSystemConfigAuthOpenidIdp'
		'Get-DracoonARSystemConfigAuthRadiu'
		'Get-DracoonARSystemConfigOauthClient'
		'Get-DracoonARSystemConfigPoliciePassword'
		'Get-DracoonARSystemConfigSettingAuth'
		'Get-DracoonARSystemConfigSettingDefault'
		'Get-DracoonARSystemConfigSettingEventlog'
		'Get-DracoonARSystemConfigSettingGeneral'
		'Get-DracoonARSystemConfigSettingInfrastructure'
		'Get-DracoonARSystemConfigSettingSyslog'
		'Get-DracoonARSystemConfigStorageS3'
		'Get-DracoonARSystemConfigStorageS3Tag'
		'New-DracoonARSystemConfigAuthAd'
		'New-DracoonARSystemConfigAuthOpenidIdp'
		'New-DracoonARSystemConfigAuthRadiu'
		'New-DracoonARSystemConfigOauthClient'
		'New-DracoonARSystemConfigPoliciePassword'
		'New-DracoonARSystemConfigSettingAuth'
		'New-DracoonARSystemConfigSettingDefault'
		'New-DracoonARSystemConfigSettingEventlog'
		'New-DracoonARSystemConfigSettingGeneral'
		'New-DracoonARSystemConfigSettingSyslog'
		'New-DracoonARSystemConfigStorageS3'
		'Remove-DracoonARSystemConfigAuthAd'
		'Remove-DracoonARSystemConfigAuthOpenidIdp'
		'Remove-DracoonARSystemConfigAuthRadiu'
		'Remove-DracoonARSystemConfigOauthClient'
		'Remove-DracoonARSystemConfigStorageS3Tag'
		'Set-DracoonARSystemConfigActionTestAd'
		'Set-DracoonARSystemConfigActionTestRadiu'
		'Set-DracoonARSystemConfigAuthAd'
		'Set-DracoonARSystemConfigAuthOpenidIdp'
		'Set-DracoonARSystemConfigAuthRadiu'
		'Set-DracoonARSystemConfigOauthClient'
		'Set-DracoonARSystemConfigPoliciePasswordEnforce_Change'
		'Set-DracoonARSystemConfigStorageS3'
		'Set-DracoonARSystemConfigStorageS3Tag'
		'New-DracoonARUpload'
		'Remove-DracoonARUpload'
		'Set-DracoonARUpload'
		'Get-DracoonARUserAccount'
		'Get-DracoonARUserAccountAvatar'
		'Get-DracoonARUserAccountCustomer'
		'Get-DracoonARUserAccountCustomerKeypair'
		'Get-DracoonARUserAccountKeypair'
		'Get-DracoonARUserNotificationConfig'
		'Get-DracoonARUserOauthApproval'
		'Get-DracoonARUserOauthAuthorization'
		'Get-DracoonARUserPing'
		'Get-DracoonARUserProfileattribute'
		'Get-DracoonARUserSubscriptionDownload_Share'
		'Get-DracoonARUserSubscriptionNode'
		'Get-DracoonARUserSubscriptionUpload_Share'
		'New-DracoonARUserAccount'
		'New-DracoonARUserAccountCustomer'
		'New-DracoonARUserAccountPassword'
		'New-DracoonARUserNotificationConfig'
		'New-DracoonARUserProfileattribute'
		'New-DracoonARUserSubscriptionDownload_Share'
		'New-DracoonARUserSubscriptionNode'
		'New-DracoonARUserSubscriptionUpload_Share'
		'Remove-DracoonARUserAccountAvatar'
		'Remove-DracoonARUserAccountKeypair'
		'Remove-DracoonARUserOauthApproval'
		'Remove-DracoonARUserOauthAuthorization'
		'Remove-DracoonARUserProfileattribute'
		'Remove-DracoonARUserSubscriptionDownload_Share'
		'Remove-DracoonARUserSubscriptionNode'
		'Remove-DracoonARUserSubscriptionUpload_Share'
		'Set-DracoonARUserAccountAvatar'
		'Set-DracoonARUserAccountKeypair'
		'Set-DracoonARUserLogout'
		'Set-DracoonARUserProfileattribute'
		'Set-DracoonARUserSubscriptionDownload_Share'
		'Set-DracoonARUserSubscriptionNode'
		'Set-DracoonARUserSubscriptionUpload_Share'
		'Get-DracoonARUser'
		'Get-DracoonARUserGroup'
		'Get-DracoonARUserLast_Admin_Room'
		'Get-DracoonARUserRole'
		'Get-DracoonARUserRoom'
		'Get-DracoonARUserUserattribute'
		'New-DracoonARUser'
		'New-DracoonARUserUserattribute'
		'Remove-DracoonARUser'
		'Remove-DracoonARUserUserattribute'
		'Set-DracoonARUser'
		'Set-DracoonARUserUserattribute'
		#endregion  AutoGenerated Funktions
	)

	# Cmdlets to export from this module
	CmdletsToExport    = ''

	# Variables to export from this module
	VariablesToExport  = ''

	# Aliases to export from this module
	AliasesToExport    = ''

	# List of all modules packaged with this module
	ModuleList         = @()

	# List of all files packaged with this module
	FileList           = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData        = @{

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