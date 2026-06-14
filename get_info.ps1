$ComputerInfo = Get-ComputerInfo
$output = [PSCustomObject]@{
    Name = ($ComputerInfo | Select-Object OsName).OsName
    Uptime = ($ComputerInfo | Select-Object OsUptime).OsUptime
    InstallDate = ($ComputerInfo | Select-Object OsInstallDate).OsInstallDate
    LargestProcess = (Get-Process | Sort-Object WS -Descending | Select-Object -Index 1).ProcessName
}
$output | ConvertTo-Csv