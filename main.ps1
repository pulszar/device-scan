# Make the script menu based instead of command line parameter input based

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
            Get-Service
            Pause
        }

        "2" {
            Get-Process
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