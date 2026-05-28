# ============================================================================
# Outputs del módulo compute
# ============================================================================

output "instance_names" {
  value       = random_pet.ec2[*].id
  description = "Nombres de las instancias EC2"
}

output "alb_dns" {
  value       = "${random_id.alb.hex}.elb.amazonaws.com"
  description = "DNS público del ALB"
}

output "app_sg_id" {
  value       = random_id.app_sg.hex
  description = "Security Group de la app — útil si data necesita autorizar acceso"
}
