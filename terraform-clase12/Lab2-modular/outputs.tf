# ============================================================================
# Outputs del root — expone los principales outputs agregados de los módulos
# ============================================================================

output "vpc_id" {
  value       = module.network.vpc_id
  description = "ID de la VPC"
}

output "ec2_names" {
  value       = module.compute.instance_names
  description = "Nombres de las instancias EC2"
}

output "rds_id" {
  value       = module.data.rds_id
  description = "ID de la RDS"
}

output "rds_password" {
  value     = module.data.rds_password
  sensitive = true
}

