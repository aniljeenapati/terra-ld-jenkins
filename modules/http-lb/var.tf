variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

variable "instance_group" {
  description = "Instance group for the backend"
  type        = string
}

variable "health_check_name" {
  description = "Name of the health check"
  type        = string
}

variable "url_map_name" {
  description = "Name of the URL map"
  type        = string
}

variable "target_proxy_name" {
  description = "Name of the target HTTP proxy"
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
  type        = string
}
