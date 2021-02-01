Register-PSFTeppScriptblock -Name "Dracoon.filter" -ScriptBlock {
    try {
        # Get inline help of configured command
        $help = get-help $commandName
        # Get help for the parameter -Filter
        $parameterHelp = $Help.parameters.parameter | Where-Object Name -EQ 'Filter'
        $filterDescription = $parameterHelp.Description.Text
        # Extract filter examples, format:
        # 'attribute:operator:[possible Values]'
        $pattern = "'(\w*?):\[?([\w, \/]*?)\]?:\[?([\w, \/]*?)\]?',?"
        $results = $filterDescription | Select-String $pattern -AllMatches
        foreach ($match in $results.Matches) {
            $attribute = $match.Groups[1]
            # Inline help may provide multiple operators, divided by '/'
            $operators = $match.Groups[2] -split '/'
            # Inline help may provide multiple value examples, divided by '/'
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
