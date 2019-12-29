function fnReverseString {

    <#

    .SYNOPSIS
    Reverses a string.

    .DESCRIPTION
     Reverses a string.

    .PARAMETER string
    This is the string to be reversed.

    .EXAMPLE
    .\Reverse-String.ps1 -string "abc"
    Reverses abc to cba

    .LINK
    https://github.com/gordonrankine/powershell

    .NOTES
        License:            MIT License
        Compatibility:      Windows 7 or Server 2008 and higher
        Author:             Gordon Rankine
        Date:               28/12/2019
        Version:            1.0
        PSSscriptAnalyzer:  Pass

    #>

    [CmdletBinding()]

        Param(

        [Parameter(Mandatory=$True, Position=0, HelpMessage='This is the string to be reveresed.')]
        [AllowEmptyString()] # This allows the error checking below to complete. Without this you will get the standard PowerShell error.
        [string]$string

        )

        if($string -eq ""){
        Write-Output "[WARNING] The string to reverse was not entered."
        }

    $array = $string.ToCharArray()
    [array]::Reverse($array)
    $revStr = -Join($array)
    $revStr

    } # end fnReverseString

Clear-Host

# Example Usage

# Set variable with string to be reversed
$stringToBeReversed = "Don't use a palindrome such as racecar."
# Run function to reverse string and hold in variable.
$stringThatIsReversed = fnReverseString $stringToBeReversed

# Output the original string and reversed string
Write-Output "[Original String] $stringToBeReversed"
Write-Output "[Reversed String] $stringThatIsReversed"
