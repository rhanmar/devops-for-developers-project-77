resource "yandex_vpc_network" "default" {
  folder_id   = var.folder_id
}

resource "yandex_vpc_subnet" "default" {
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.5.0.0/24"]
  folder_id   = var.folder_id
}
