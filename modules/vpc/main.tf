resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
  ip_cidr_range = "10.10.0.0/24"
}
