module "network" {
  source       = "./modules/network"
  network_name = "my-vpc"
  subnet_name  = "my-subnet"
  region       = "us-central1"
}

module "compute" {
  source       = "./modules/compute"
  network_name = module.network.network_name
  subnet_name  = module.network.subnet_name
  region       = "us-central1"
}

module "http_lb" {
  source         = "./modules/http_lb"
  instance_group = module.compute.instance_group
}

module "tcp_lb" {
  source         = "./modules/tcp_lb"
  instance_group = module.compute.instance_group
}
