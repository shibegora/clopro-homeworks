terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.129.0"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
  token     = "y0_AgAAAABm7uImAATuwQAAAAEY4ThOAAA1Sy5x92RKI6XVqVTOVr-ZK89R5A"
}