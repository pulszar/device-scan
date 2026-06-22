FROM mcr.microsoft.com/azure-powershell:latest
# FROM azuresdk/azure-powershell-core

COPY main/machine_type.ps1 .
COPY main/get_info.ps1 .
COPY main/batch_machine.ps1 .

ENTRYPOINT ["pwsh", "./main/machine_type.ps1"]