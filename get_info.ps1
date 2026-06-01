$output = [PSCustomObject]@{
    Name = (Get-ComputerInfo | Select-Object OsName).OsName
    Uptime = (Get-ComputerInfo | Select-Object OsUptime).OsUptime
    InstallDate = (Get-ComputerInfo | Select-Object OsInstallDate).OsInstallDate
    LargestProcess = (Get-Process | Sort-Object WS -Descending | Select-Object -Index 1).ProcessName
}
$output | ConvertTo-Csv