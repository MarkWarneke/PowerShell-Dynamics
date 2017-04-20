<#
Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

Author: Mark Warneke
Created: 12-04-17
#>

<#
.Synopsis
 synopsis

.Description
Enables the tracing of a Dynamics 2009 
Edits the Regsitrykey of a certain path


.Parameter Path 
 Path to the regestry entry of the trancingstart property

.Example
 Start-Dynamics2009Tracing.ps1 
 Output: 1 for enabled or 0 for disabled tracing

#>


# A DWORD is a 32-bit unsigned integer (range: 0 through 4294967295 decimal). Because a DWORD is unsigned, its first bit (Most Significant Bit (MSB)) is not reserved for signing
# Variables

$RegistryPath = "HKLM:\SYSTEM\ControlSet001\services\Dynamics Server\"
$DynamicsServerPath = "5.0\01\AX593"

$Path = $RegistryPath + $DynamicsServerPath

$Name = "tracestart"    # Property name
$Value = "1"            # Property value

# Test if path exists, if not create, if than set value

if(!(Test-Path $Path )) {
     throw "Error: Path $Path not found"
}

New-ItemProperty -Path $Path -Name $Name -Value $Value `
    -PropertyType DWORD -Force 
    
