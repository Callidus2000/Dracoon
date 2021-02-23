function New-DracoonDownloadShare {
    <#
    .SYNOPSIS
    Creates a Download Share for an existing file node

    .DESCRIPTION
    API-POST /v4/shares/downloads

    .PARAMETER connection
    Object of Class , stores the authentication Token and the API Base-URL

    .PARAMETER NodeId
    Node-ID  of the file

    .PARAMETER Notes
    Description notes for the share

    .PARAMETER InternalNotes
    Internal Description notes for the share

    .PARAMETER ShareName
    Descriptive Name of the download share.

    .PARAMETER MaxDownloads
    How often should the file be downloadable? 0 for infinity.

    .PARAMETER ShowCreatorName
    Should the Share-Creator-Name be displayed? Defaults to true

    .PARAMETER ShowCreatorUsername
    Should the Share-Creator-Username be displayed? Defaults to false

    .PARAMETER NotifyCreator
    Should the creator be informed about any download? Defaults to true

    .PARAMETER Password
    Password for accessing the shared file. See .PARAMETER RandomPassword

    .PARAMETER RandomPassword
    If used the password is generated randomly.

    .PARAMETER TextMessageRecipients
    Optional Array of text message recipients

    .PARAMETER whatIf
    If enabled it does not execute the backend API call.

    .PARAMETER confirm
    If enabled the backend API Call has to be confirmed

    .PARAMETER ExpirationDate
    Sets a date when the user will expire

    .PARAMETER EnableException
    If set to true, inner exceptions will be rethrown. Otherwise the an empty result will be returned.

    .EXAMPLE
    New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -MaxDownloads 2

    Creates a download share which lasts for 2 downloads.

    .EXAMPLE
    New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -Password "fsdjfdsfhj8934234****"

    Creates a download share with set password

    .EXAMPLE
    New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -RandomPassword

    Creates a download share with a random access password.

    .EXAMPLE
    New-DracoonDownloadShare -Connection $connection -NodeId $NodeId -RandomPassword -TextMessageRecipients "0123456789"

    Creates a download share with a random access password, sends the password to the given mobile number

    .NOTES
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '')]
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [parameter(Mandatory = $true)]
        $Connection,
        [parameter(Mandatory = $true)]
        [int]$NodeId,
        [string]$Notes = "",
        [string]$InternalNotes = "",
        [string]$ShareName = "Download-Share",
        [bool]$ShowCreatorName = $true,
        [bool]$ShowCreatorUsername = $false,
        [bool]$NotifyCreator = $true,
        [string[]]$TextMessageRecipients,
        [int]$MaxDownloads=0,
        [string]$Password,
        [switch]$RandomPassword,
        [datetime]$ExpirationDate,
        [bool]$EnableException = $false
    )
    Write-PSFMessage "Creating Download Share for Node $NodeId"
    if ($RandomPassword){
        $Password=(New-DracoonRandomPassword)
    }
    $apiCallParameter = @{
        Connection = $Connection
        method     = "Post"
        Path       = "/v4/shares/downloads"
        Body       = @{
            "nodeId"                = $NodeId
            "name"                  = $ShareName
            # "password"              = $Password
            "expiration"            = @{
                "enableExpiration" = $false
                "expireAt"         = "2018-01-01T00:00:00"
            }
            "internalNotes"         = $InternalNotes
            "notes"                 = $notes
            "showCreatorName"       = $ShowCreatorName
            "showCreatorUsername"   = $ShowCreatorUsername
            "notifyCreator"         = $NotifyCreator
            # "maxDownloads"          = 0
            "creatorLanguage"       = "de-DE"
            "receiverLanguage"      = "de-DE"
            # "textMessageRecipients" = @(
            #     "string"
            # )
            "sendMail"              = $false
            # "sendSms"               = $true
            # "smsRecipients"         = "string"
        }
        # EnablePaging=$true
    }
        if ($ExpirationDate) {
        $apiCallParameter.Body.expiration.enableExpiration = 'true'
        $apiCallParameter.Body.expiration.expireAt = $ExpirationDate.ToString('yyyy-MM-ddT00:00:00')
    }
    if ($TextMessageRecipients){
        $apiCallParameter.Body.textMessageRecipients = @($TextMessageRecipients)
    }
    if ($Password){
        $apiCallParameter.Body.password = $Password
    }
    if ($MaxDownloads -gt 0){
        $apiCallParameter.Body.maxDownloads = $MaxDownloads
    }

    Invoke-PSFProtectedCommand -Action "Creating new download-share" -Target "$NodeId" -ScriptBlock {
        $result = Invoke-DracoonAPI @apiCallParameter
        # Write-PSFMessage "User erfolgreich angelegt"
        $result
    } -PSCmdlet $PSCmdlet -EnableException $EnableException
}