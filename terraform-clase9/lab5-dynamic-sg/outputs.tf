output "security_group_id" {
  description = "ID del Security Group creado."
  value       = aws_security_group.web.id
}

output "allowed_ports" {
  description = "Puertos usados para generar reglas ingress."
  value       = var.allowed_ports
}
