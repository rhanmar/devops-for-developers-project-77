resource "local_file" "ansible_inventory" {
  content = templatefile("../ansible/templates/inventory.ini.template", {
    app_server_1_ip    = yandex_compute_instance.app-srv-1.network_interface.0.nat_ip_address
    app_server_2_ip    = yandex_compute_instance.app-srv-2.network_interface.0.nat_ip_address
  })
  filename = "../ansible/inventory.ini"
}

resource "local_file" "ansible_secrets" {
  content = templatefile("../ansible/templates/vault.yml.template", {
    db_host     = yandex_mdb_postgresql_cluster.db-cluster.host[0].fqdn
    db_name     = var.db_name
    db_username = var.db_user
    db_password = var.db_password
    db_port     = "6432"

    datadog_api_key = var.datadog_api_key
    datadog_site    = var.datadog_site

    app_port = var.app_port

    ssh_login = var.ssh_login
  })
  filename = "../ansible/group_vars/webservers/vault.yml"
}
