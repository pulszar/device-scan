param (
    [string]$Type,
    [string]$RG,
    [string]$Name,
    [string]$Location
)

function GetAzureArcVM { # gets info on an Azure Arc enabled VM
    $script = Get-Content -Raw .\get_info.ps1
    New-AzConnectedMachineRunCommand `
        -ResourceGroupName $RG `
        -MachineName $Name `
        -Location $Location `
        -RunCommandName 'RunCommandName' `
        -SourceScript $script
}

function GetAzureNativeVM { # gets info on a native Azure VM
    Invoke-AzVMRunCommand `
        -ResourceGroupName "$RG" `
        -VMName "$Name" `
        -CommandId 'RunPowerShellScript' `
        -ScriptPath .\get_info.ps1
}

switch ($Type) {
    "Local" { .\get_info.ps1 } 
    "AzureArc" { GetAzureArcVM }
    "AzureNative" { GetAzureNativeVM }
    default   { Write-Host "Usage: 
    *Local Machine*
    .\device_info.ps1 -Type Local
    
    *Azure Arc Enabled Machine*
    .\device_info.ps1 -Type AzureArc 
        -RG ResourceGroup
        -Name MachineName
        -Location Location
        
    *Azure Native Machine*
    .\device_info.ps1 -Type AzureNative
        -RG ResourceGroup
        -Name MachineName
        " 
    } 
}
