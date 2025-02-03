resource "google_compute_instance_template" "template" {
  name        = "web-instance-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    boot         = true
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install -y apache2
    echo '<h1>Welcome to GCP Load Balancer</h1>' | sudo tee /var/www/html/index.html
    sudo systemctl restart apache2
  EOT
}

resource "google_compute_region_instance_group_manager" "mig" {
  name               = "web-mig"
  base_instance_name = "web-instance"
  region            = var.region
  version {
    instance_template = google_compute_instance_template.template.self_link
  }
}
