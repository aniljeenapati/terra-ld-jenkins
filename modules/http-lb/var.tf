variable "machine_type" {
  description = "Machine type for the instance template"
  type        = string
  default     = "e2-medium"
}

variable "source_image" {
  description = "Source image for the instance template"
  type        = string
  default     = "debian-cloud/debian-10"
}

variable "network" {
  description = "Network for the instance template"
  type        = string
  default     = "default"
}

variable "mig_name" {
  description = "Name of the Managed Instance Group"
  type        = string
}

variable "zone" {
  description = "Zone for the Managed Instance Group"
  type        = string
}

variable "target_size" {
  description = "Target size for the Managed Instance Group"
  type        = number
  default     = 2
}

variable "backend_service_name" {
  description = "Name of the backend service"
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
