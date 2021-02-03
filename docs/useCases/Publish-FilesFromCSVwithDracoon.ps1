<#PSScriptInfo

 .VERSION 1.0.0
 .GUID 0c864d18-7563-47d8-9a91-2282c1cbe655
 .AUTHOR Sascha Spiekermann
 .TAGS Dracoon,Usecase
 .EXTERNALMODULEDEPENDENCIES Dracoon,PSFramework
 .REQUIREDSCRIPTS
 .EXTERNALSCRIPTDEPENDENCIES
 .RELEASENOTES
 #>

<#
  .DESCRIPTION
  This script retrieves information from a CSV file. The file has three columns:
  -File
  -Mail
  -Password
  -Mobile
  -Sent

  The file uploads the named file to Dracoon and sends a download link to the given Mail address.
  If the Mobile attribute exists it does send the password by TextMessage.
 #>
 #region Modify according your environment
$clientId = Get-PSFConfigValue "Dracoon.pester.clientId" -ErrorAction Stop
$clientSecret = Get-PSFConfigValue "Dracoon.pester.clientSecret" -ErrorAction Stop
$credentials = Get-PSFConfigValue "Dracoon.pester.credentials" -ErrorAction Stop
$fqdn = Get-PSFConfigValue "Dracoon.pester.fqdn" -ErrorAction Stop
$metaDataFilename = "$PSScriptRoot\Publish-FilesFromCSVwithDracoon.csv"
$mailBody="Sent to you by Dracoon"
$uploadRoomId =1115
#endregion
# Connect to the Dracoon Server
$connection = Connect-Dracoon -Url "$fqdn" -ClientID $ClientID -clientSecret $clientSecret -Credential $credentials

# Import the MetaData
$metaData=Import-Csv -Path $metaDataFilename -Delimiter ";"
foreach ($data in $metaData){
    try {
        $uploadFile = Publish-DracoonFile -Connection $connection -FilePath $data.File -EnableException $true -ParentNodeId $uploadRoomId
        $newShareParameter=@{
            Connection=$connection
            NodeId=$uploadFile.id
            EnableException=$true
            Password=$data.Password
        }
        if ($data.Mobile){
            $newShareParameter.TextMessageRecipients = $data.Mobile
        }
        $newShare=New-DracoonDownloadShare @newShareParameter
        Send-DracoonDownloadShareMail -Connection $connection -Id $newShare.id -Recipient $data.Mail -MailBody $mailBody -EnableException $true
    }
    catch {
        Write-Host "Error sending $data"
    }
}