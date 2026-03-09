resource "yandex_compute_instance" "app-srv-1" {
  name        = "app-srv-1"
  platform_id = var.platform_id
  zone        = var.zone
  folder_id   = var.folder_id

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true // вкл внешний IP
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: ${var.ssh_login}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${file(var.ssh_key_path)}
      EOF
  }

  depends_on = [yandex_mdb_postgresql_cluster.db-cluster, yandex_mdb_postgresql_database.db_name]
}

resource "yandex_compute_instance" "app-srv-2" {
  name        = "app-srv-2"
  platform_id = var.platform_id
  zone        = var.zone
  folder_id   = var.folder_id

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 15
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true // вкл внешний IP
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: ${var.ssh_login}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
          - ${file(var.ssh_key_path)}
      EOF
  }

  depends_on = [yandex_mdb_postgresql_cluster.db-cluster, yandex_mdb_postgresql_database.db_name]
}
