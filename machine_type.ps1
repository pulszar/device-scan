param (
    [string]$Type,
    [string]$RG,
    [string]$Name,
    [string]$Location
)

function GetLocal {
    $LocalCsv = .\get_info.ps1 
    $LocalObj = $LocalCsv | ConvertFrom-Csv
    $LocalObj | Format-List
}
function GetAzureArcVM { # gets info on an Azure Arc enabled VM
    try {
        # Gets raw script text to run as an argument in the following Azure cmdlet
        $script = Get-Content -Raw .\get_info.ps1 -ErrorAction Stop
    } catch {
        $ErrorMessage = $_.Exception.Message
        Write-Host -ForegroundColor Red "Error: Missing VM information retrieval script"
        Write-Host -ForegroundColor Red $ErrorMessage
    }
    $result = New-AzConnectedMachineRunCommand `
        -ResourceGroupName $RG `
        -MachineName $Name `
        -Location $Location `
        -RunCommandName 'RunCommandName' `
        -SourceScript $script

    $final_output = foreach ($field in $result.InstanceViewOutput) { Write-Output $field }
    $final_output | Format-List
}

function GetAzureNativeVM { # gets info on a native Azure VM
    $NativeResult = Invoke-AzVMRunCommand `
        -ResourceGroupName "$RG" `
        -VMName "$Name" `
        -CommandId 'RunPowerShellScript' `
        -ScriptPath .\get_info.ps1

    $NativeFinalCsv = $NativeResult.Value[0].Message
    $NativeFinalObj = $NativeFinalCsv | ConvertFrom-Csv 
    $NativeFinalObj | Format-List
}

switch ($Type) {
    "Local" { GetLocal }
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
