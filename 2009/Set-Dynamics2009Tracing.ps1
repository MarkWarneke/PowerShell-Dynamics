<#
Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

.DESCRIPTION
Sets the value of the tracestart according to the user input.
Prompts the user for the tracestart value 0 for disable or 1 for enable.
Validates the userinput and prompts error messages.
If successfull prompt the current state.
If failed shows simple error message.
.NOTES
TODO Unter der Instanz 01 ist ein Current Property, welches die Current instanz anzeig.
Damit kann dann das ChildItem auf Basis des Current Value genommen werden 

Author: Mark Warneke
Created: 12-04-17
.LINK
#>


[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [int]$Value
)

$Name = "tracestart"
$RegistryPath = "HKLM:\SYSTEM\ControlSet001\services\Dynamics Server\"
$DynamicsServerPath = "5.0\01\AX593"
$Path = $RegistryPath + $DynamicsServerPath

# Validate userinput of value
if( ! ($Value -eq 1 -or $Value -eq 0)) {
    throw "Error: Choose value 0 for disable or 1 for enable"
}

# Validate path to registry
if( ! (Test-Path $Path )) {
    throw "Error: $Path not found." 
}

try {
    echo "Change registry property $Name Value to $Value"

    New-ItemProperty -Path $Path -Name $Name -Value $Value `
        -PropertyType DWORD -Force 
    
    echo "Registry property $Name changed to $Value"
} catch {
    "Property $Name could NOT be changed to $Value"
} finally {

}

