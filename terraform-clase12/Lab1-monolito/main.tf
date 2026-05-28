
# =============================================
terraform {
  required_version = ">= 1.5"
  required_providers {
    random = { source = "hashicorp/random", version = "~> 3.5" }
    local  = { source = "hashicorp/local", version = "~> 2.4" }
  }
}

# ---------------------------------------------
# variable unica
variable "environment" {
    type = string
    default = "dev"
}

# =========================================================
# CAPA NETWORK - VPC + subnets
resource "random_id" "vpc" {
    byte_length = 4
    prefix = "vpc-${var.environment}-"
}

resource "random_id" "subnet_public" {
    count = 2
    byte_length = 4
    prefix = "subnet-pub-"
}

resource "random_id" "subnet_private" {
    count = 2
    byte_length = 4
    prefix = "subnet-pub-"
}


# =========================================================
# CAPA COMPUTE - EC2 + ALB + SG
resource "random_pet" "ec2" {
  count  = 2
  length = 2
  prefix = "web"
}

resource "random_id" "alb" {
  byte_length = 4
  prefix      = "alb-"
}

resource "random_id" "app_sg" {
  byte_length = 4
  prefix      = "sg-app-"
}


# =========================================================
# CAPA DATA - RDS

resource "random_id" "rds" {
  byte_length = 4
  prefix      = "rds-"
}

resource "random_password" "rds_password" {
  length = 16
  special      = false
}

resource "local_file" "summary" {
    filename = "${path.module}/infra-summary.txt"
    content = <<-EOT
        +++++++++++++++++++++++++++++++++++++++++++++
        INFRA DESPLEGADA MONOLITO - env : ${var.environment}
        +++++++++++++++++++++++++++++++++++++++++++++
        VPC :                   ${random_id.vpc.hex}
        SG :                    ${random_id.app_sg.hex}
        EC2 INSTANCE :          ${join(", ", random_pet.ec2[*].id)}
        RDS :                   ${random_id.rds.hex}
        +++++++++++++++++++++++++++++++++++++++++++++
    EOT
}


# =========================================================
# OUTPUTS
output "vpc_id" {value = random_id.vpc.hex }
output "ec2_names" {value = random_pet.ec2[*].id }
output "rds_id" {value = random_id.rds.hex }