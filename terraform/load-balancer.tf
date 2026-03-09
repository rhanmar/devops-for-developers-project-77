### Target groups
resource "yandex_alb_target_group" "app-target-group" {
  name = "app-target-group"

  target {
    subnet_id  = yandex_vpc_subnet.default.id
    ip_address = yandex_compute_instance.app-srv-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.default.id
    ip_address = yandex_compute_instance.app-srv-2.network_interface.0.ip_address
  }

}


### Backend groups
resource "yandex_alb_backend_group" "app-backend-group" {
  name = "app-backend-group"

  http_backend {
    name             = "app-backend"
    weight           = 1
    port             = var.app_port
    target_group_ids = [yandex_alb_target_group.app-target-group.id]

    healthcheck {
      timeout             = "1s"
      interval            = "3s"
      healthy_threshold   = 1
      unhealthy_threshold = 3
      http_healthcheck {
        path = "/"
      }
    }
  }
}


### HTTP router
resource "yandex_alb_http_router" "app-router" {
  name = "app-router"
}


### Virtual host
resource "yandex_alb_virtual_host" "app-virtual-host" {
  name           = "app-virtual-host"
  http_router_id = yandex_alb_http_router.app-router.id

  route {
    name = "main-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.app-backend-group.id
        timeout          = "3s"
      }
    }
  }
}


### Load Balancer
resource "yandex_alb_load_balancer" "app-load-balancer" {
  name       = "app-load-balancer"
  network_id = yandex_vpc_network.default.id

  allocation_policy {
    location {
      zone_id   = var.zone
      subnet_id = yandex_vpc_subnet.default.id
    }
  }

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [var.app_port]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.app-router.id
      }
    }
  }

}
