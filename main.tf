module "http_lb" {
  source = "../../modules/http-lb"

  machine_type         = "e2-medium"
  source_image         = "debian-cloud/debian-10"
  network              = "default"
  mig_name             = "dev-mig"
  zone                 = "us-central1-a"
  target_size          = 2
  backend_service_name = "dev-backend-service"
  health_check_name    = "dev-health-check"
  url_map_name         = "dev-url-map"
  target_proxy_name    = "dev-target-proxy"
  forwarding_rule_name = "dev-forwarding-rule"
}
