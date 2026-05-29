# Device Info
This is a script that retrieves information from your computer to better help you understand what that computer might be used for.

## Usage
**outdated theres command line arguments now but too lazy to update all this rn**

For use on your local computer:
``` ps
. 'path\to\script'
```

For use on an Azure VM:
``` ps
Invoke-AzVMRunCommand -ResourceGroupName 'rgname' -VMName 'vmname' -CommandId 'RunPowerShellScript' -ScriptPath 'path\to\script'
```

For use on an Azure Arc enabled VM:
``` ps
# This ones a bit weird because Azure docs says -ScriptLocalPath is a flag but returns an error stating it wasn't found. Workaround is to set a variable to the raw script and feed it directly to the -SourceScript command that works.

$script = Get-Content -Raw 'path\to\script'

New-AzConnectedMachineRunCommand -ResourceGroupName 'rgname' -MachineName 'vmname' -Location 'location' -RunCommandName 'RunCommandName' –SourceScript $script      
```