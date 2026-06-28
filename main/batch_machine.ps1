# If batching many machines via a CSV is used, this will be the looping layer on top

param (
    [string]$MachineCsv
)

$Machines = Import-Csv -Path $MachineCsv

$output = foreach ($Machine in $Machines) { 
    .\main\machine_type.ps1 `
        -Type $Machine.Type `
        -RG $Machine.RG `
        -Location $Machine.Location `
        -Name $Machine.Name `
        -Subscription $Machine.Subscription
}

# $output
$output | Export-Csv -Path '.\batch_inventory.csv' -NoTypeInformation
# $output

