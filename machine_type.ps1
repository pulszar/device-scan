param (
    [string]$Type,
    [string]$RG,
    [string]$Name,
    [string]$Location
)

function GetAzureArcVM { # gets info on an Azure Arc enabled VM
    try {
        # Gets raw script text to run as an argument in the following Azure cmdlet
        Get-Content -Raw .\get_info.ps1 -ErrorAction Stop
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Host -ForegroundColor Red "Error: Missing VM information retrieval script"
        Write-Host -ForegroundColor Red $ErrorMessage
    }
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
    default { 
    
    Write-Error `
    "Incorrect parameters. Usage: 

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
