terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.2.0"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "vm-inventory" {
  name         = "pulzsar/vm-inventory"
  keep_locally = false
}

resource "docker_container" "vm-inventory" {
  image = docker_image.vm-inventory.image_id
  name  = "vm-inventory"

  # The equivalent of docker run -it
  stdin_open = true
  tty = true

  # Ideas to enter the Docker terminal upon terraform apply

#   provisioner "local-exec" {
#     command = "docker exec -t vm-inventory pwsh ./main.ps1"
#   }
#   attach = true
#   entrypoint = ["pwsh", "./main.ps1"]
#   ports {
#     internal = 80
#     external = 8000
#   }
}

