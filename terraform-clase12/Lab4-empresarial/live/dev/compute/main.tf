# CAPA COMPUTE - live/dev/compute


terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.5" }
    local  = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

# leer outputs de la capa network
data "terraform_remote_state" "network" {
    backend = "local"
    config = {
        path = "../network/terraform.tfstate"
    }
}

# llamar al compute, pasandole datos de network
module "compute" {
    source = "../../../modules/compute"
    vpc_id = data.terraform_remote_state.network.outputs.vpc_id
    subnet_ids  = data.terraform_remote_state.network.outputs.public_subnet_ids
    app_name    = "webapp"
    environment = "dev"
}


output "alb_dns"   { value = module.compute.alb_dns }
output "app_sg_id" { value = module.compute.app_sg_id }

resource "local_file" "summary" {
  filename = "${path.module}/compute-summary.txt"
  content  = <<-EOT
    COMPUTE deployed en dev
    ========================
    VPC leído de network:   ${data.terraform_remote_state.network.outputs.vpc_id}
    Subnets usadas:         ${join(", ", data.terraform_remote_state.network.outputs.public_subnet_ids)}
    ALB DNS:                ${module.compute.alb_dns}
    EC2:                    ${join(", ", module.compute.instance_names)}
  EOT
}
