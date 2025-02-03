module "http_lb" {
  source = "../../modules/http-lb"

  backend_service_name  = "dev-backend-service"
  instance_group        = "projects/anil-449609/zones/us-central1-a/instanceGroups/dev-instance-group"
  health_check_name     = "dev-health-check"
  url_map_name          = "dev-url-map"
  target_proxy_name     = "dev-target-proxy"
  forwarding_rule_name  = "dev-forwarding-rule"
}
