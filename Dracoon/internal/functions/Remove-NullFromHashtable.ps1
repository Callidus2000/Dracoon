function Remove-NullFromHashtable {
    <#
    .SYNOPSIS
    Funktion zum Entfernen von $null Werten aus HashTables.

    .DESCRIPTION
    Funktion zum Entfernen von $null Werten aus HashTables. Dazu wird die HashTable in einen json String umgewandelt
    und anschließend per RegEx alle null-Werte entfernt. Falls InputHashmap -eq $null dann wird nichts zurückgegeben.

    .PARAMETER InputHashmap
    Die Eingabe-HashTable

    .PARAMETER Json
    Wird der Parameter gesetzt, so wird anstatt einer neuen HashTable der modifizierte json String zurück geliefert

    .EXAMPLE
    $hash=@{
        Name="Max"
        Surname="Mustermann"
        MiddleName=$null
        kids=@(
            @{
                Name="Maxi"
                MiddleName=$null
                Surname="Mustermann"
            },
            @{
                Name="Maxine"
                MiddleName="Christine"
        Surname="Mustermann"
            }
        )
    }
    $newHash=$hash  | Remove-NullFromHashtable
    .NOTES
    General notes
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    param (
        [Parameter(ValueFromPipeline)]
        [hashtable]$InputHashmap,
        [switch]$Json
    )

    process {
        if ($InputHashmap) {
            $tempString = $InputHashmap | ConvertTo-Json -Depth 15
            Write-PSFMessage -Level Debug "Entferne null Values aus $tempString"
            $tempString = $tempString -replace '"\w+?"\s*:\s*null,?'
            Write-PSFMessage -Level Debug "Ergebnis: $tempString"
            if ($Json) { $tempString }else {
                Write-PSFMessage -Level Debug "Erzeuge HashTable"
                $newHashmap = $tempString | ConvertFrom-Json
                $newHashmap
            }
        }
    }
}