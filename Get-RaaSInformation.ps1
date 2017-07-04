$Computername = "localhost"
$rObject = New-Object psobject -Property @{
    ComputerName = $null
    AOSInstanceFound = $false
    AOSInstance = $null
}

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