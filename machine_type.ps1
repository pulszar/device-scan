param (
    [string]$ComputerType,
    [string]$ResourceGroupInput,
    [string]$MachineNameInput,
    [string]$LocationInput
)

function GetAzureArcVM { # gets info on an Azure Arc enabled VM
    $script = Get-Content -Raw .\get_info.ps1
    New-AzConnectedMachineRunCommand `
        -ResourceGroupName $ResourceGroupInput `
        -MachineName $MachineNameInput `
        -Location $LocationInput `
        -RunCommandName 'RunCommandName' `
        –SourceScript $script
}

switch ($ComputerType) {
    "Local" { .\get_info.ps1 } 
    "AzureArc" { GetAzureArcVM }
    default   { Write-Host "Usage: .\device_info.ps1 -ComputerType Local" } 
}
