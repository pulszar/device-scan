$output = [PSCustomObject]@{
    Name = Get-ComputerInfo | Select-Object OsName
    Uptime = Get-ComputerInfo | Select-Object OsUptime
    InstallDate = Get-ComputerInfo | Select-Object OsInstallDate
    LargestProcess = (Get-Process | Sort-Object WS -Descending | Select-Object -Index 1).ProcessName

}

$output