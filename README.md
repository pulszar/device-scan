# Device Info
This is a script that retrieves information from either your local computer, Azure VM, or Azure Arc enabled VM to better help you understand what that computer might be used for.

## Usage

### Local

Extract local machine details:
``` ps
.\main\machine_type.ps1 -Type Local -ExportCsv {True/False}
```

Azure Arc Enabled Machine
``` ps
.\main\machine_type.ps1 -Type AzureArc -Subscription Subscription -RG ResourceGroup -Name MachineName -Location Location -ExportCsv {True/False}
```

Azure VM 
```ps
.\main\machine_type.ps1 -Type AzureNative -Subscription Subscription -RG ResourceGroup -Name MachineName -ExportCsv {True/False}
```
### Docker
***Local scan and csv export is **unsupported** when running with Docker***

Build the image
```ps
docker build -t device_scan .
```
Run the container with command line arguments
```ps
docker run device_scan {Parameters}
```