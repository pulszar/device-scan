# Useful `cmdlets`

## `Get-ComputerInfo`
System and operating system properties. Fields of note:
- OsInstallDate
- OsUptime
- OsName
## `Get-HotFix`
Lists hotfixes, which are small patches applied after the OS was released.
## `Get-Service` and `Get-Process`
Service | Process
-|-
Special kind of process | Any running program
Designed to run in the background | Includes services

## `Get-WindowsFeature`
Server manager `cmdlet`. Only installed on servers.

Lists the roles of the server. For example it, it will show if its a web server or not.
## `Get-EventLog`
Views all logs from a certain event log like `System`, `Application`, and `Security`. Good for troubleshooting errors and crashes, config updates, tracking service start/stop times.
## `Get-CimInstance`
"Common Information Model"

Queries Windows Management Instrumentation (WMI). Helps read information from:
- `Win32_OperatingSystem` - `SystemDirectory`, `Organization`, `BuildNumber`, `RegisteredUser`, `SerialNumber`, `Version`
- `Win32_ComputerSystem` - `Name`, `PrimaryOwnerName`, `Domain`, `TotalPhysicalMemory`, `Model`, `Manufacturer`
- `Win32_Process` - `ProcessId`, `Name`, `HandleCount`, `WorkingSetSize`, `VirtualSize`
    - `WorkingSetSize`: Memory currently in use
    - `VirtualSize`: Total virtual address space the process is using
## `Invoke-Command`
Run commands on multiple computers. Example:


``` ps
Invoke-Command -ComputerName Server01, Server02 -ScriptBlock { Get-Service } 
```
## `Export-Csv`
Converts objects into CSV strings and saves to a file
## `ConvertTo-Json`
Converts objects into a JSON formatted string and saves to a file

## `Invoke-AzVMRunCommand`
Remotely execute commands or scripts on Azure VMs