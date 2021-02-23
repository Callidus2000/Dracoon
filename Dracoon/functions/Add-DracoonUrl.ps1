function Add-DracoonUrl {
    <#
    .SYNOPSIS
    This function allows the addition of new Server-URLs for TAB Completion.
    Each function which requires a -Url parameter will provide a TAB completer with suggested URLs.

    .DESCRIPTION
    This function allows the addition of new Server-URLs for TAB Completion.
    Each function which requires a -Url parameter will provide a TAB completer with suggested URLs,
    e.g. Connect-Dracoon

    Different from Set-DracoonUrl this command does not overwrite but append to existing settings.

    .PARAMETER NewUrl
    The new URLs to be added

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .EXAMPLE
    Add-DracoonUrl 'https://dxi.mydomain'

    Add a single Server to the list of suggested URLs

    (get-adforest -ErrorAction Stop).domains | ForEach-Object { Add-DracoonUrl "https://dataexchange.$($_)" }
    If you have an on prem Dracoon server in each of your Windows Domains with the address "https://dracoon.<yourdomain>"
    it will get added to the list of suggested URLs.

    .NOTES
    The URLs get saved at the PSF-Config "Dracoon.tepp.urls"
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'low')]
    param (
        [parameter(mandatory = $true, Position = 0)]
        [string[]]$NewUrl
    )
    Write-PSFMessage "Adding new Urls for the URL TEPP: $NewUrl"
    $oldUrl=Get-PSFConfigValue "Dracoon.tepp.urls"
    Write-PSFMessage "Existing Urls for the URL TEPP: $oldUrl"
    $combinedUrls=@()
    $combinedUrls+=$NewUrl
    if ($oldUrl) {
        $combinedUrls+=$oldUrl
    }
    # Adjusting format of URLs
    $combinedUrls = $combinedUrls | ForEach-Object { Get-DracoonServerRoot $_ }
    # Sorting and filtering unique
    $combinedUrls=$combinedUrls | Sort-Object | Select-Object -Unique
    Write-PSFMessage "combined Urls for the URL TEPP: $combinedUrls"
    Invoke-PSFProtectedCommand -Action "Saving new Urls for the URL TEPP" -Target "$NewUrl" -ScriptBlock {
        Set-PSFConfig -Module 'Dracoon' -Name 'tepp.urls' -Value $combinedUrls -PassThru | Register-PSFConfig
    } -PSCmdlet $PSCmdlet
}