param (
    [string]$MachineCsv
)

$Machines = Import-Csv -Path $MachineCsv

$output = foreach ($Machine in $Machines) { 
    .\machine_type.ps1 `
        -Type $Machine.Type `
        -RG $Machine.RG `
        -Location $Machine.Location `
        -Name $Machine.Name
}

$output | Export-Csv -Path '.\batch_inventory.csv' -NoTypeInformation

