function fnCreateDir {

<#

.SYNOPSIS
Creates a directory.

.DESCRIPTION
Creates a directory.

.PARAMETER outDir
This is the directory to be created.

.EXAMPLE
.\Create-Directory.ps1 -outDir "c:\test"
Creates a directory called "test" in c:\

.EXAMPLE
.\Create-Directory.ps1 -outDir "\\COMP01\c$\test"
Creates a directory called "test" in c:\ on COMP01

.LINK
https://github.com/gordonrankine/powershell

.NOTES
    License:            MIT License
    Compatibility:      Windows 7 or Server 2008 and higher
    Author:             Gordon Rankine
    Date:               13/01/2019
    Version:            1.1
    PSSscriptAnalyzer:  Pass

#>

    [CmdletBinding()]

        Param(

        # The directory to be created.
        [Parameter(Mandatory=$True, Position=0, HelpMessage='This is the directory to be created. E.g. C:\Temp')]
        [string]$outDir

        )

        # Create out directory if it doesnt exist
        if(!(Test-Path -path $outDir)){
            if(($outDir -notlike "*:\*") -and ($outDir -notlike "*\\*")){
            Write-Output "[ERROR]: $outDir is not a valid path. Script terminated."
            break
            }
                try{
                New-Item $outDir -type directory -Force -ErrorAction Stop | Out-Null
                Write-Output "[INFO] Created output directory $outDir"
                }
                catch{
                Write-Output "[ERROR]: There was an issue creating $outDir. Script terminated."
                Write-Output ($_.Exception.Message)
                Write-Output ""
                break
                }
        }
        # Directory already exists
        else{
        Write-Output "[INFO] $outDir already exists."
        }

} # end fnCreateDir

Clear-Host

<# Examples
fnCreateDir "c:\temp"
fnCreateDir "\\Comp01\c$\temp"
#>
