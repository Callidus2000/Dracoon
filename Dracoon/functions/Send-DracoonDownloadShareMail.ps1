function Send-DracoonDownloadShareMail {
    <#
    .SYNOPSIS
    Sends an E-Mail for an existing Download Share.

    .DESCRIPTION
    API-POST /v4/shares/downloads/{share_id}/email

    .PARAMETER connection
    Object of Class [Dracoon], stores the authentication Token and the API Base-URL

    .PARAMETER Id
    ID  of the existing Download Share

    .PARAMETER MailBody
    Body for the generated Mail

    .PARAMETER Recipients
    Optional Array of text message recipients

    .PARAMETER ReceiverLanguage
    Language of the receiver

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    $newShare=New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -MaxDownloads 2
    $currentUser=Get-DracoonCurrentAccount -Connection $connection
    Send-DracoonDownloadShareMail -Connection $connection -Id $newShare.id -Recipient $currentUser.email -MailBody "This is the body"

    Sends an E-Mail to the current user mail address.

    .NOTES
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [parameter(Mandatory = $true)]
        [Dracoon]$Connection,
        [parameter(Mandatory = $true)]
        [int]$Id,
        [parameter(Mandatory = $true)]
        [string]$MailBody,
        [parameter(Mandatory = $true)]
        [string[]]$Recipients,
        [string]$ReceiverLanguage = "de-DE",
        [bool]$EnableException = $false
    )
    Write-PSFMessage "Creating E-Mail for Download Share $Id"
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/shares/downloads/$Id/email"
        Body       = @{
            "recipients"       = @($Recipients)
            "body"             = $MailBody
            "receiverLanguage" = $ReceiverLanguage
        }
    }
    Invoke-PSFProtectedCommand -Action "Creating E-Mail for Download Share" -Target "$Id" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter -EnableException $EnableException
        $result
    } -PSCmdlet $PSCmdlet -EnableException $EnableException
}