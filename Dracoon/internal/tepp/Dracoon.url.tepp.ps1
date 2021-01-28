Register-PSFTeppScriptblock -Name "Dracoon.url" -ScriptBlock {
    $staticList=@('https://dracoon.team')
    try {
        $urlList=Get-PSFConfigValue "Dracoon.tepp.urls" -Fallback $staticList
        return $urlList
    }
    catch {
        return $staticList
    }
}
