Register-PSFTeppScriptblock -Name "Dracoon.filter" -ScriptBlock {
    try {
        $help = get-help $commandName
        $parameterHelp = $Help.parameters.parameter | Where-Object Name -EQ 'Filter'
        $filterDescription = $parameterHelp.Description.Text
        $pattern = "'(\w*?):\[?([\w, \/]*?)\]?:\[?([\w, \/]*?)\]?',?"
        $results = $filterDescription | Select-String $pattern -AllMatches
        foreach ($match in $results.Matches) {
            $attribute = $match.Groups[1]
            $operators = $match.Groups[2] -split '/'
            $valueExamples = $match.Groups[3] -split '/'
            foreach ($operator in $operators) {
                foreach ($value in $valueExamples) {
                    "'$($attribute):$($operator):$($value)'"
                }
            }
        }
    }
    catch {
        Write-PSFMessage -Level Debug "Could not load filter information from Get-Help $commandName"
    }
}
