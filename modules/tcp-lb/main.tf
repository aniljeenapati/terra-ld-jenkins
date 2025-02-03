resource "google_compute_health_check" "tcp_health" {
  name               = "tcp-health-check"
  timeout_sec        = 10
  check_interval_sec = 10
  tcp_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "tcp_backend" {
  name          = "tcp-backend-service"
  protocol      = "TCP"
  health_checks = [google_compute_health_check.tcp_health.self_link]
  backend {
    group = var.instance_group
  }
}

resource "google_compute_target_tcp_proxy" "tcp_proxy" {
  name    = "tcp-proxy"
  backend_service = google_compute_backend_service.tcp_backend.self_link
}

resource "google_compute_global_forwarding_rule" "tcp_rule" {
  name       = "tcp-forwarding-rule"
  target     = google_compute_target_tcp_proxy.tcp_proxy.self_link
  port_range = "80"
}
