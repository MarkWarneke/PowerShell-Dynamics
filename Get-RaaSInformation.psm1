#REQUIRES -Version 4.0

<#
DISCLAIMER:

     This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment.

             THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED AS IS
             WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
             TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.

     We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and
     to reproduce and distribute the object code form of the Sample Code,
     provided that You agree:
     (i) 	 to not use Our name, logo, or trademarks to market Your software
             product in which the Sample Code is embedded; 
     (ii) 	 include a valid copyright notice on Your software product in which 
             the Sample Code is embedded; and 
     (iii) 	 to indemnify, hold harmless, and defend Us and Our suppliers from and 
             against any claims or lawsuits, including attorneys' fees, that arise 
             or result from the use or distribution of the Sample Code.

     Please note: None of the conditions outlined in the disclaimer above will supersede terms and conditions contained within the Premier Customer Services Description.

     ALL CODE MUST BE TESTED BY ANY RECIPIENTS AND SHOULD NOT BE RUN IN A PRODUCTION ENVIRONMENT WITHOUT MODIFICATION BY THE RECIPIENT.

     Author: Mark Warneke <mark.warneke@microsoft.com>
     Created: <mm-dd-yyyy>


HELP

     .SYNOPSIS
         RaaS Client Setup

     .DESCRIPTION
         PowerShell script to gather information to make the RaaS Client start collecting

     .PARAMETER
         Computername

     .EXAMPLE
        Get-RaaSInfromation

         C:\PS> Get-RaaSInformation
#>


<#
Brief descirption of the fuction.
#>
function Get-RaaSInformation {
    [CmdletBinding()]
    [OutputType([psobject])]
    param(
        [Parameter()]
        [string] $Computername
    )
    
    begin {
        if(!$Computername) {
            $Computername = "localhost"
        }

        $rObject = New-Object psobject -Property @{
            ComputerName = $null
            AOSInstanceFound = $false
            AOSInstance = $null
        }
    }
    
    process {

        Write-Verbose("Obtaining Win32_ComputerSystem object for Computername")
        $computer = Get-WmiObject Win32_ComputerSystem -ComputerName $Computername
        $rObject.ComputerName = $computer.Name
                
        Write-Verbose("Obtaining AOS Service Instances won't throw error due to wildecard search")
        $aos = Get-Service | ? { $_.Status -eq "Running" -AND $_.DisplayName -match "Microsoft Dynamics AX Object" }

        Write-Verbose("Could potentially find no AOS nothing")
        try {
            $rObject.AOSInstance = $aos[0].Name
            $rObject.AOSInstanceFound = $true                    
        }
        catch {
            Write-Error("AOS service instances not found")
            $rObject.AOSInstance = "01"
        }

        Write-Verbose("Returning custom object")
        $rObject
      
    }
    
    end {
    }
}

export-modulemember -function Get-RaaSInformation