resource "google_compute_backend_service" "default" {
  name        = var.backend_service_name
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = var.instance_group
  }

  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_health_check" "default" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name    = var.target_proxy_name
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}
