# Make the script menu based instead of command line parameter input based

# function Select-LocalEnv {
#     Write-Host "Executing machine_type.ps1..."
#     .\main\machine_type.ps1 -Type "Local"
# }

function Select-DockerEnv {
    $Type = Read-Host "Enter the type (AzureArc or AzureNative)"
    $RG = Read-Host "Enter the resource group"
    $Location = Read-Host "Enter the location/region"
    $Name = Read-Host "Enter the VM name"
    $Subscription = Read-Host "Enter the subscription"

    Write-Host "Executing machine_type.ps1..."
    .\main\machine_type.ps1 `
        -Type $Type `
        -RG $RG `
        -Location $Location `
        -Name $Name `
        -Subscription $Subscription
}

do {
    Clear-Host
    Write-Host "=== Welcome To Device Scan! ==="
    Write-Host "Please select the environment you are in:"
    Write-Host "1. Local"
    Write-Host "2. Docker container"
    Write-Host "Q. Quit"
    Write-Host ""

    $choice = (Read-Host "Choose an option").ToUpper()

    switch ($choice) {
        "1" {
            Select-LocalEnv
            Pause
        }

        "2" {
            Select-DockerEnv
            Pause
        }
        
        "Q" {
            Write-Host "Exiting..."
        }

        default {
            Write-Host "Invalid option."
            Pause
        }
    }

} until ($choice -eq "Q")