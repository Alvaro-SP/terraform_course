
terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.5" }
    local  = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

# ----------------------------------------------------------------------------
# Mismo patrón que compute: leer state de network
# ----------------------------------------------------------------------------
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/terraform.tfstate"
  }
}

module "data" {
  source             = "../../../modules/data"
  vpc_id             = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  environment        = "dev"
}

output "rds_endpoint" { value = module.data.rds_endpoint }

resource "local_file" "summary" {
  filename = "${path.module}/data-summary.txt"
  content  = <<-EOT
    DATA deployed en dev
    ====================
    VPC leído de network:        ${data.terraform_remote_state.network.outputs.vpc_id}
    Subnets privadas usadas:     ${join(", ", data.terraform_remote_state.network.outputs.private_subnet_ids)}
    RDS endpoint:                ${module.data.rds_endpoint}

  EOT
}
