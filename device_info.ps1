param (
    [string]$ComputerType
)

function GetInfo {
    $output = [PSCustomObject]@{
        Name = Get-ComputerInfo | Select-Object OsName
        Uptime = Get-ComputerInfo | Select-Object OsUptime
        InstallDate = Get-ComputerInfo | Select-Object OsInstallDate
        LargestProcess = (Get-Process | Sort-Object WS -Descending | Select-Object -Index 1).ProcessName
    }
    $output | Format-List
}

switch ($ComputerType) {
    "Local" { $output = GetInfo }
    default   { Write-Host "Usage: .\device_info.ps1 -ComputerType Local" } # will build out support for azure VMs
}

