Import-Module AutoRest
$mySwaggerFile = "$PSScriptRoot\Dracoon-SRV-spec_v4.json"

$paramConvertFromARSwagger = @{
    Transformpath = "$PSScriptRoot\Transform"
    RestCommand   = 'Invoke-DracoonAPI'
    ModulePrefix  = 'DracoonAR'
    PathPrefix    = '/v4'
    ConvertToHashtableCommand='ConvertTo-DracoonARHashtable'
}
Write-PSFMessage -Level Host "Create Command Array"
$swaggerCommands = $mySwaggerFile | ConvertFrom-ARSwagger @paramConvertFromARSwagger #-Verbose
Write-PSFMessage -Level Host "Removing existing Command Files"
Get-ChildItem "$PSScriptRoot\out"|remove-item -recurse -confirm:$false
Write-PSFMessage -Level Host "Create Command Files"
$swaggerCommands | Export-ARCommand -Path $PSScriptRoot\out -GroupByEndpoint -Force