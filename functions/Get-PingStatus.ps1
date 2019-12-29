function fnGetPingStatus {

<#

.SYNOPSIS
Gets ping status code for an endpoint.

.DESCRIPTION
Gets ping status code for an endpoint. The script will return $TRUE for on or $FALSE for off.
There are 3 methods that can be used to determine ping status; WMI, CIM or Native (PowerShell's Test-Connection cmdlet).

.PARAMETER endpoint
This endpoint to get the ping status for.

.EXAMPLE
fnGetPingStatusWmi -endpoint SERVER01 -method WMI
Returns the ping status of SERVER01 using the WMI method.

.EXAMPLE
fnGetPingStatusWmi -endpoint SERVER01 -method CIM
Returns the ping status of SERVER01 using the CIM method.

.EXAMPLE
fnGetPingStatusWmi -endpoint SERVER01 -method Native
Returns the ping status of SERVER01 using the Native (PowerShell's Test-Connection cmdlet) method.

.LINK
https://github.com/gordonrankine/powershell

.NOTES
    License:            MIT License
    Compatibility:      Windows 7 or Server 2008 and higher
    Author:             Gordon Rankine
    Date:               29/12/2019
    Version:            1.0
    PSSscriptAnalyzer:  Pass (with caveat). Run ScriptAnalyzer with PSAvoidUsingWMICmdlet. WMI included as an option for backwards compatibility.

#>

    [CmdletBinding()]
    [OutputType([System.Boolean])] #Defines output type as boolean for function. Without this Script Analyzer fails.

        Param(

        [Parameter(Mandatory=$True, Position=0, HelpMessage='This is the endpoint to be pinged. E.g. localhost')]
        [string]$endpoint,
        [Parameter(Mandatory=$True, Position=1, HelpMessage='This is the method to be used to get the status.')]
        [ValidateSet('WMI','CIM','Native')]
        [string]$method

        )

        # Set as default.
        $reachable = $FALSE

            # WMI Method
            if($method -eq 'WMI'){

                try{
                $sc = (Get-WmiObject -query "select * from Win32_pingStatus Where Address='$endpoint'").StatusCode

                    if($sc -eq 0){
                    $reachable = $TRUE
                    }
                    else{
                    $reachable = $FALSE
                    }


                return $reachable

                }
                catch{
                Write-Output "[ERROR] There was an unexpected error while checking the ping status. Script terminated."
                Write-Output ($_.Exception.Message)
                Break
                }

            }

            # CIM Method
            if($method -eq 'CIM'){

                try{
                $sc = (Get-CimInstance -query "select * from Win32_pingStatus Where Address='$endpoint'").StatusCode

                    if($sc -eq 0){
                    $reachable = $TRUE
                    }
                    else{
                    $reachable = $FALSE
                    }


                return $reachable

                }
                catch{
                Write-Output "[ERROR] There was an unexpected error while checking the ping status. Script terminated."
                Write-Output ($_.Exception.Message)
                Break
                }

            }

            # Native
            if($method -eq 'Native'){

                try{

                    # If this fails then StatusCode doesn't return a value. So can't use that method like above in WMI/CIM.
                    if(Test-Connection -ComputerName $endpoint -Count 1 -Quiet){
                    $reachable = $TRUE
                    }
                    else{
                    $reachable = $FALSE
                    }

                return $reachable

                }
                catch{
                Write-Output "[ERROR] There was an unexpected error while checking the ping status. Script terminated."
                Write-Output ($_.Exception.Message)
                Break
                }

            }

            # No else to catch anything outwith validate set as PowerShell throws an error before this block would be executed.

} # end fnGetPingStatus

# Example
Clear-Host
# Set variable
$isOn = fnGetPingStatus -endpoint localhost -method Native
# Output variable
Write-Output $isOn
