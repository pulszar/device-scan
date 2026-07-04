FROM mcr.microsoft.com/azure-powershell:latest

WORKDIR /app

COPY . .

ENTRYPOINT ["pwsh", "./main.ps1"]