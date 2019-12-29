function fnGetEpochTimestamp {

<#

.SYNOPSIS
Gets the current epoch timestamp.

.DESCRIPTION
Get the current epoch timestamp.

.EXAMPLE
fnGetEpochTimestamp
Gets the current epoch timestamp.

.LINK
https://github.com/gordonrankine/powershell

.NOTES
    License:            MIT License
    Compatibility:      Windows 7 or Server 2008 and higher
    Author:             Gordon Rankine
    Date:               29/12/2019
    Version:            1.0
    PSSscriptAnalyzer:  Pass

#>

[int][double]::Parse((Get-Date -UFormat %s))

} #end fnGetEpochTimestamp

# Example
Clear-Host
# Assign to variable
$epoch = fnGetEpochTimestamp
# Output variable
Write-Output $epoch