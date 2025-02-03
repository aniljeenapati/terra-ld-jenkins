module "vpc" {
  source       = "./modules/network"
  network_name = "my-vpc"
  subnet_name  = "my-subnet"
  region       = "us-central1"
}

module "mig" {
  source       = "./modules/compute"
  network_name = module.network.network_name
  subnet_name  = module.network.subnet_name
  region       = "us-central1"
}

module "http-lb" {
  source         = "./modules/lb"
  instance_group = module.compute.instance_group
}
