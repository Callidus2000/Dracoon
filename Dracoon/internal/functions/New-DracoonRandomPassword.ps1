function New-DracoonRandomPassword {
    <#
    .SYNOPSIS
    Creates a new random password.

    .DESCRIPTION
    Creates a new random password with the following rules:
    -12 characters long
    -at least one lower case character
    -at least one upper case character
    -at least one number
    -at least one special character

    .EXAMPLE
    $newPassword=New-DracoonRandomPassword
    Creates a new password

    .NOTES
    General notes
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    param()
    process {
        [int]$PasswordLength = 12

        # Specifies an array of strings containing charactergroups from which the password will be generated.
        # At least one char from each group (string) will be used.
        [String[]]$InputStrings = @('abcdefghijkmnpqrstuvwxyz', 'ABCEFGHJKLMNPQRSTUVWXYZ', '23456789', '!"#%&')

        $Password = @{ }
        # Create char arrays containing groups of possible chars
        [char[][]]$CharGroups = $InputStrings

        # Create char array containing all chars
        $AllChars = $CharGroups | ForEach-Object { [Char[]]$_ }

        # Randomize one char from each group
        Foreach ($Group in $CharGroups) {
            if ($Password.Count -lt $PasswordLength) {
                $Index = Get-DracoonSeed
                While ($Password.ContainsKey($Index)) {
                    $Index = Get-DracoonSeed
                }
                $Password.Add($Index, $Group[((Get-DracoonSeed) % $Group.Count)])
            }
        }

        # Fill out with chars from $AllChars
        for ($i = $Password.Count; $i -lt $PasswordLength; $i++) {
            $Index = Get-DracoonSeed
            While ($Password.ContainsKey($Index)) {
                $Index = GetSeed
            }
            $Password.Add($Index, $AllChars[((Get-DracoonSeed) % $AllChars.Count)])
        }
        return $( -join ($Password.GetEnumerator() | Sort-Object -Property Name | Select-Object -ExpandProperty Value))
    }
}
function Get-DracoonSeed {
    # Generate a seed for randomization
    $RandomBytes = New-Object -TypeName 'System.Byte[]' 4
    $Random = New-Object -TypeName 'System.Security.Cryptography.RNGCryptoServiceProvider'
    $Random.GetBytes($RandomBytes)
    return [BitConverter]::ToUInt32($RandomBytes, 0)
}