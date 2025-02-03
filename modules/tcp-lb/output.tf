output "tcp_lb_ip" {
  value = google_compute_global_forwarding_rule.tcp_rule.ip_address
}
