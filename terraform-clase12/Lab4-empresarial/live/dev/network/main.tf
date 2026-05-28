# CAPA NETWORK — live/dev/network

terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.5" }
    local  = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

# llamar al modulo desde los modulos
module "network" {
  source      = "../../../modules/network"
  environment = "dev"
}

output "vpc_id"             { value = module.network.vpc_id }
output "public_subnet_ids"  { value = module.network.public_subnet_ids }
output "private_subnet_ids" { value = module.network.private_subnet_ids }

resource "local_file" "summary" {
  filename = "${path.module}/network-summary.txt"
  content  = "VPC: ${module.network.vpc_id}\nSubnets públicas: ${join(", ", module.network.public_subnet_ids)}\nSubnets privadas: ${join(", ", module.network.private_subnet_ids)}\n"
}
