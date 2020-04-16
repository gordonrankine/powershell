    function fnCheckPaswordComplexity {

    <#
    .SYNOPSIS
    Checks password complexity.

    .DESCRIPTION
     Checks password complexity against a minimum set of requirements. The password must contain an uppercase character, a lowercase character,`
     a number and a special character. The password must also meet the minimun length requirement as specified in the script.

    .PARAMETER minPwLen
    The minimum length of the password.

    .EXAMPLE
    See end of the script for a usage example.

    .LINK
    https://github.com/gordonrankine/powershell

    .NOTES
        License:            MIT License
        Compatibility:      Windows 7 or Server 2008 and higher
        Author:             Gordon Rankine
        Date:               16/04/2020
        Version:            1.0
        PSSscriptAnalyzer:  Pass
    #>

    [CmdletBinding()]

    Param(

        [Parameter(Mandatory=$True, Position=0, HelpMessage='This is the minimum password length to be checked.')]
        [System.Int32]$minPwLen

        )

    $msgText = "Password Complexity Rules:`
     - must be $minPwLen characters or more.`
     - must contain an uppercase character.`
     - must contain a lowercase character.`
     - must contain a number.`
     - must contain a special character.`n`n"

    # Prompt for password, convert to string for error checking
    $pw1 = Read-Host -Prompt "Please enter a password.`n`n$msgText" -AsSecureString
    $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
    $pass = 0

        # while password doesnt meet requirements
        while ($pass -eq 0){

            # password doesnt meet minimum length requirement
            if($pw1Text.Length -lt $minPwLen){
            $pw1 = Read-Host -Prompt "[ERROR] The password must be $minPwLen characters or more.`n`nPlease enter a password.`n`n$msgText" -AsSecureString
            $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
            $pass = 0
            }

            # password doesnt contain an uppercase character
            elseif(!($pw1Text -cmatch "[A-Z]")){
            $pw1 = Read-Host -Prompt "[ERROR] The password must contain an uppercase character.`n`nPlease enter a password.`n`n$msgText" -AsSecureString
            $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
            $pass = 0
            }

            # password doesnt contain an lowercase character
            elseif(!($pw1Text -cmatch "[a-z]")){
            $pw1 = Read-Host -Prompt "[ERROR] The password must contain an lowercase character.`n`nPlease enter a password.`n`n$msgText" -AsSecureString
            $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
            $pass = 0
            }

            # password doesnt contain a number
            elseif(!($pw1Text -cmatch "[0-9]")){
            $pw1 = Read-Host -Prompt "[ERROR] The password must be contain a number.`n`nPlease enter a password.`n`n$msgText" -AsSecureString
            $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
            $pass = 0
            }

            # password doesnt contain a special character
            elseif(!($pw1Text -match "[^a-zA-Z0-9]")){
            $pw1 = Read-Host -Prompt "[ERROR] The password must be contain a special character.`n`nPlease enter a password.`n`n$msgText" -AsSecureString
            $pw1Text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw1))
            $pass = 0
            }

            # password meets complexity, passed.
            else{
            $pass = 1
            return $pw1
            }

        }

    } #fnCheckPaswordComplexity

    function fnCheckPaswordsMatch {

    $pwCon = Read-Host -Prompt "Please confirm password.`n" -AsSecureString

    # Convert to strings for error checking
    $pass1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwNew))
    $pass2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwCon))

        while (!($pass1 -ceq $pass2)) {

        Clear-Host

        # Get confirm password again
        $pwCon = Read-Host -Prompt "[ERROR] Password does not match.`n`nPlease confirm password.`n" -AsSecureString
        $pass2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwCon))

        }

    return $True

    } #fnCheckPaswordsMatch


Clear-Host
# Get password and check complexity. The number at the end dictates the minimum password length
$pwNew = fnCheckPaswordComplexity(12)
# Check passwords match
$pwMatch = fnCheckPaswordsMatch

    if($pwMatch -eq $True){
    Write-Output "Your password has passed complexity checks and can now be used. Please use the variable `$pwNew."
    }
