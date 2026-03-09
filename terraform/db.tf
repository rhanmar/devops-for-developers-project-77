resource "yandex_mdb_postgresql_cluster" "db-cluster" {
  name                = "db"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.default.id
  deletion_protection = false

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 22
  }

  config {
    version = 15
    resources {
      resource_preset_id = "c3-c2-m4"
      disk_type_id       = "network-hdd"
      disk_size          = 10
    }
    postgresql_config = {
      max_connections = 100
    }
  }

  host {
    zone             = var.zone
    name             = "postgresql-host"
    subnet_id        = yandex_vpc_subnet.default.id
    assign_public_ip = false
  }
}

resource "yandex_mdb_postgresql_user" "db-user" {
  cluster_id = yandex_mdb_postgresql_cluster.db-cluster.id
  name       = var.db_user
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "db_name" {
  cluster_id = yandex_mdb_postgresql_cluster.db-cluster.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.db-user.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"

  depends_on = [yandex_mdb_postgresql_user.db-user]
}