FROM demisto/powershell:7.5.0.9017890

COPY machine_type.ps1 ./

ENTRYPOINT ["pwsh", "./machine_type.ps1"]