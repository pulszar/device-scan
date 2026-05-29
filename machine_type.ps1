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
        -SourceScript $script
}

function GetAzureNativeVM { # gets info on a native Azure VM
    Invoke-AzVMRunCommand `
        -ResourceGroupName "$ResourceGroupInput" `
        -VMName "$MachineNameInput" `
        -CommandId 'RunPowerShellScript' `
        -ScriptPath .\get_info.ps1
}

switch ($ComputerType) {
    "Local" { .\get_info.ps1 } 
    "AzureArc" { GetAzureArcVM }
    "AzureNative" { GetAzureNativeVM }
    default   { Write-Host "Usage: 
    *Local Machine*
    .\device_info.ps1 -ComputerType Local
    
    *Azure Arc Enabled Machine*
    .\device_info.ps1 -ComputerType AzureArc 
        -ResourceGroupInput ResourceGroup
        -MachineNameInput MachineName
        -LocationInput Location
        
    *Azure Native Machine*
    .\device_info.ps1 -ComputerType AzureNative
        -ResourceGroupInput ResourceGroup
        -MachineNameInput MachineName
        " 
    } 
}
