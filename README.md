# Device Info
This is a script that retrieves information from either your local Windows computer, Azure VM, or Azure Arc enabled VM (or all three) to easily retrieve inventory information from specified VM(s). 

## Features

- Run inventory scan on your local machine, Azure Arc, or Azure native VM
- Scan individual VMs
- Scan batch VMs via input CSV

## Installation
```
git clone https://github.com/pulszar/device-scan.git
cd device-scan
```
## Usage
### Local
Run the `main.ps1` file:
```ps1
.\main.ps1
```
### Docker
***Local scan and csv import and export are **unsupported** when running with Docker***

Pull the image from DockerHub
```ps
docker pull pulzsar/vm-inventory
```
Run the container in interactive mode to use the command line
```ps
docker run -it pulzsar/vm-inventory
```

### Terraform

Run the Terraform commands:

```terraform
terraform init
terraform plan
terraform apply
```

Then use `exec` to execute `main.ps1` in order to enter the Docker terminal:
```ps
docker exec -it vm-inventory pwsh ./main.ps1
```
After use, don't forget to destroy the image and container!
```
terraform destroy
```

### Azure Container Services (WIP)

1. Create container in portal
2. Run the following in the cloud console:
```ps
az container exec --resource-group {ResourceGroup} --name vm-inventory --container-name vm-inventory --exec-command "pwsh ./main.ps1"
```