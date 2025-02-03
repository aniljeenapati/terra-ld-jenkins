resource "google_compute_health_check" "http_health" {
  name               = "http-health-check"
  timeout_sec        = 10
  check_interval_sec = 10
  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "backend" {
  name          = "backend-service"
  health_checks = [google_compute_health_check.http_health.self_link]
  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "url_map" {
  name            = "url-map"
  default_service = google_compute_backend_service.backend.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
}
