# Instance Template
resource "google_compute_instance_template" "default" {
  name_prefix = "instance-template-"
  description = "Instance template for HTTP Load Balancer backend"

  machine_type = var.machine_type
  tags         = ["http-server"]

  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

# Managed Instance Group (MIG)
resource "google_compute_instance_group_manager" "default" {
  name               = var.mig_name
  base_instance_name = "http-lb-instance"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.default.self_link
  }

  target_size = var.target_size

  auto_healing_policies {
    health_check      = google_compute_health_check.default.self_link
    initial_delay_sec = 300
  }
}

# Backend Service
resource "google_compute_backend_service" "default" {
  name        = var.backend_service_name
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = google_compute_instance_group_manager.default.instance_group
  }

  health_checks = [google_compute_health_check.default.self_link]
}

# Health Check
resource "google_compute_health_check" "default" {
  name = var.health_check_name

  http_health_check {
    port = 80
  }
}

# URL Map
resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.default.self_link
}

# Target HTTP Proxy
resource "google_compute_target_http_proxy" "default" {
  name    = var.target_proxy_name
  url_map = google_compute_url_map.default.self_link
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "default" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}
