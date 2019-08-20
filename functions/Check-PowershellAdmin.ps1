function fnCheckPSAdmin {

<#

.SYNOPSIS
Checks PowerShell is running as Administrator.

.DESCRIPTION
Checks PowerShell is running as Administrator.

.LINK
https://github.com/gordonrankine/powershell

.NOTES
    License:            MIT License
    Compatibility:      Windows 7 or Server 2008 and higher
    Author:             Gordon Rankine
    Date:               19/09/2019
    Version:            1.0
    PSSscriptAnalyzer:  Pass

#>

    try{
    $wIdCurrent = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $wPrinCurrent = New-Object System.Security.Principal.WindowsPrincipal($wIdCurrent)
    $wBdminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

        if(!$wPrinCurrent.IsInRole($wBdminRole)){
        Write-Output "[ERROR] PowerShell is not running as administrator. Script terminated."
        Break
        }

    }

    catch{
    Write-Output "[ERROR] There was an unexpected error checking if PowerShell is running as administrator. Script terminated."
    Break
    }

} # end fnCheckPSAdmin

<# Examples
fnCheckPSAdmin
#>
