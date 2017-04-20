<#
Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose. 
This mail message assumes that you are familiar with the programming language that is being demonstrated and the tools that are used to create and debug procedures.
#requires -version 2.0

.DESCRIPTION
Get the tracing status of the Dynamics 2009 AOS from a certain registrypath
if the registry path does NOT exists it will prompt a short errormessage and exit the script
.NOTES
Author: Mark Warneke
Created: 12-04-17
.LINK
#>

# Define Variables
$RegistryPath = "HKLM:\SYSTEM\ControlSet001\services\Dynamics Server\"
$DynamicsServerPath = "5.0\01\AX593"
$Path = $RegistryPath + $DynamicsServerPath

$Names = ("tracestart", "logdir")


# Validate path to registry
if( ! (Test-Path $Path )) {
    throw "Error: $Path not found."
}

# Get tracestart value
foreach ($name in $Names) {
    echo $name + " " + (Get-ItemProperty -Path $Path -Name $name).$name
}

