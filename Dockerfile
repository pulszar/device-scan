FROM mcr.microsoft.com/azure-powershell:latest
# FROM azuresdk/azure-powershell-core

COPY machine_type.ps1 .
COPY get_info.ps1 .
COPY batch_machine.ps1 .

ENTRYPOINT ["pwsh", "./machine_type.ps1"]