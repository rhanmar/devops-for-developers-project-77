terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "yandex" {
  zone      = var.zone
  token     = var.yc_token
  folder_id = var.folder_id
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = var.datadog_api_url
}
