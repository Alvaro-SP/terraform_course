
output "rds_id" {
  value       = random_id.rds.hex
  description = "ID de la instancia RDS"
}

output "rds_endpoint" {
  value       = "${random_id.rds.hex}.region.rds.amazonaws.com"
  description = "Endpoint de conexión"
}

output "rds_password" {
  value       = random_password.rds_password.result
  sensitive   = true
  description = "Contraseña de la RDS — siempre marcar sensitive"
}
