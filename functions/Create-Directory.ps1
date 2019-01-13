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

.LINK
https://github.com/gordonrankine/powershell

.NOTES
    License:            MIT License
    Compatibility:      Windows 7 or Server 2008 and higher
    Author:             Gordon Rankine
    Date:               13/01/2019
    Version:            1.0
    PSSscriptAnalyzer   Pass

#>

Clear-Host

function fnCreateDir {

    [CmdletBinding()]

        Param(

        # The directory to be created.
        [Parameter(Mandatory=$True, Position=0, HelpMessage='This is the directory to be created. E.g. C:\Test')]
        [string]$outDir

        )

        # Create out directory if it doesnt exist
        if(!(Test-Path -path $outDir)){
            try{
            New-Item $outDir -type directory -Force -ErrorAction Stop | Out-Null
            Write-Output "[SUCCESS] Created output directory $outDir"
            }
            catch{
            Write-Output "[ERROR]: There was an issue creating $outDir. Script terminated."
            Write-Output ($_.Exception.Message)
            Write-Output ""
            break
            }
        }
        # Directory already exists
        else{
        Write-Output "[INFO] $outDir already exists."
        }

} # end fnCreateDir

# Example
fnCreateDir c:\test
