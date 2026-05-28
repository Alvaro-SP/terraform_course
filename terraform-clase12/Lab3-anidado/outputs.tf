# ============================================================================
# Outputs del módulo padre app-stack — RE-EXPONE los de los hijos
# ============================================================================

output "vpc_id" {
  value       = module.network.vpc_id
  description = "ID de la VPC (expuesto por network)"
}

output "public_subnet_ids" {
  value       = module.network.public_subnet_ids
  description = "Subnets públicas (expuesto por network)"
}

output "private_subnet_ids" {
  value       = module.network.private_subnet_ids
  description = "Subnets privadas (expuesto por network)"
}

output "instance_names" {
  value       = module.compute.instance_names
  description = "Nombres de las instancias EC2 (expuesto por compute)"
}

output "alb_dns" {
  value       = module.compute.alb_dns
  description = "DNS público del ALB (expuesto por compute)"
}

output "app_sg_id" {
  value       = module.compute.app_sg_id
  description = "Security Group de la app (expuesto por compute)"
}

output "rds_id" {
  value       = module.data.rds_id
  description = "ID de la RDS (expuesto por data)"
}
