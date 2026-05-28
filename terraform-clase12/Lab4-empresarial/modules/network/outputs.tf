
output "vpc_id" {
  value       = random_id.vpc.hex
  description = "ID de la VPC — lo consume compute y data"
}

output "public_subnet_ids" {
  value       = random_id.subnet_public[*].hex
  description = "Subnets públicas — las consume compute para el ALB"
}

output "private_subnet_ids" {
  value       = random_id.subnet_private[*].hex
  description = "Subnets privadas — las consume data para la RDS"
}
