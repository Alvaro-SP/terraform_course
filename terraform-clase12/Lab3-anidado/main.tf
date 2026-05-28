# MODULO PADRE


module "network" {
    source = "./modules/network"
    environment = var.environment
}

module "data" {
  source             = "./modules/data"
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  environment        = var.environment
}

module "compute" {
  source     = "./modules/compute"
  vpc_id     = module.network.vpc_id
  subnet_ids = concat(module.network.public_subnet_ids, module.network.private_subnet_ids)
  app_name   = var.app_name
  environment = var.environment
}