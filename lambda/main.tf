terraform {
  required_version = ">= 0.12"

  required_providers {
    aws = {
      version = ">= 3.26"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}