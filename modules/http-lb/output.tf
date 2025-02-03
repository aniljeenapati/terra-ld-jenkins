output "forwarding_rule_ip" {
  description = "IP address of the HTTP Load Balancer"
  value       = google_compute_global_forwarding_rule.default.ip_address
}
