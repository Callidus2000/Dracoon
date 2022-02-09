if(Get-PSFConfigValue -FullName "Dracoon.enableAutoRest" -FallBack $false){
    Write-PSFMessage "Importing Auto-Created functions"
    # Import all functions created by AutoRest
    foreach ($function in (Get-ChildItem "$ModuleRoot\internal\autorest\out" -Filter "*.ps1" -Recurse -ErrorAction Ignore)) {
        . Import-ModuleFile -Path $function.FullName
    }
}else {
    Write-PSFMessage "NOT Importing Auto-Created functions"
    Set-PSFConfig -Module 'Dracoon' -Name 'enableAutoRest' -Value $true -Pass
}