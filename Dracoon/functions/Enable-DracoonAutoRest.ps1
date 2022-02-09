function Enable-DracoonAutoRest {
    <#
    .SYNOPSIS
    Enables the auto created functions *-DracoonAR*.

    .DESCRIPTION
    This module does provide functions for all endpoints. Those are created by the AutoRest module.

    .PARAMETER SaveSetting
    Should the setting be saved as default for the current user?

    .EXAMPLE
    Enable-DracoonAutoRest
    Import-Module Dracoon -Force

    Enables the AutoRest functions.

    .NOTES
    All the AutoRest functions
    -are provided as-is
    -are no supported
    -are not tested or monitored by the pester tests
    #>
    [CmdletBinding()]
    param (
        [switch]$SaveSetting
    )

    $config=Set-PSFConfig -Module 'Dracoon' -Name 'enableAutoRest' -Value $true -PassThru
    Write-PSFMessage -Level Host "AutoRest-Functions disabled, please Re-Import the Dracoon Module with the '-Force' option"
    if ($SaveSetting) {
        $config | Register-PSFConfig -Scope UserDefault
    }
    else {
        Write-PSFMessage -Level Host "The functions are only enabled for this session. Use the '-SaveSetting' option if it should be the default for the current User."
    }
}