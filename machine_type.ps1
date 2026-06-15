param (
    [string]$Type,
    [string]$RG,
    [string]$Name,
    [string]$Location,
    [string]$Subscription,
    [string]$ExportCsv = "False" # True or False
)

function ExportToCsv {
    param (
        $Obj
    )
    if ($ExportCsv -eq "True") {
        $Obj | Export-Csv -Path '.\inventory.csv' -NoTypeInformation
    }
}

function GetLocal {
    $LocalCsv = .\get_info.ps1 
    $LocalObj = $LocalCsv | ConvertFrom-Csv
    $LocalObj | Format-List

    ExportToCsv -Obj $LocalObj
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


    $ArcObj = $result.InstanceViewOutput | ConvertFrom-Csv | Format-List
    $ArcObj

    ExportToCsv -Obj $ArcObj
}

function GetAzureNativeVM { # gets info on a native Azure VM
    $NativeResult = Invoke-AzVMRunCommand `
        -ResourceGroupName "$RG" `
        -VMName "$Name" `
        -CommandId 'RunPowerShellScript' `
        -ScriptPath .\get_info.ps1

    $NativeCsv = $NativeResult.Value[0].Message
    $NativeObj = $NativeCsv | ConvertFrom-Csv 
    $NativeObj | Format-List

    ExportToCsv -Obj $NativeObj
}

Connect-AzAccount -UseDeviceAuthentication -Subscription $Subscription

switch ($Type) {
    "Local" { GetLocal }
    "AzureArc" { GetAzureArcVM }
    "AzureNative" { GetAzureNativeVM }
    default { 
    
    Write-Error `
    "Incorrect parameters. Usage: 

    *Local Machine*
    .\machine_type.ps1 -Type Local -ExportCsv {True/False}
    
    *Azure Arc Enabled Machine*
    .\machine_type.ps1 -Type AzureArc 
        -RG ResourceGroup
        -Name MachineName
        -Location Location
        -ExportCsv {True/False}
        
    *Azure Native Machine*
    .\machine_type.ps1 -Type AzureNative
        -RG ResourceGroup
        -Name MachineName
        -ExportCsv {True/False}
    "

    } 
}
