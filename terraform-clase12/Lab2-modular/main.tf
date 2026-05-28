# ============================================================================
# PASO 2 — ROOT (modular)
# ============================================================================
# Root que orquesta los 3 módulos planos: `network`, `data`, `compute`.
# =============================================================================

terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.5" }
    local  = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

module "network" {
  source      = "./modules/network"
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

resource "local_file" "summary" {
  filename = "${path.module}/infra-summary.txt"
  content  = <<-EOT
    ============================================================
    INFRAESTRUCTURA DESPLEGADA — env: ${var.environment}
    ============================================================
    VPC:               ${module.network.vpc_id}
    Subnets públicas:  ${join(", ", module.network.public_subnet_ids)}
    Subnets privadas:  ${join(", ", module.network.private_subnet_ids)}
    EC2 instances:     ${join(", ", module.compute.instance_names)}
    ALB:               ${module.compute.alb_dns}
    App Security Group: ${module.compute.app_sg_id}
    RDS:               ${module.data.rds_id}
    ============================================================
  EOT
}

