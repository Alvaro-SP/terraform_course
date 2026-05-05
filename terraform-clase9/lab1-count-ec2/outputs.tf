output "ami_usada" {
  description = "AMI Ubuntu seleccionada automáticamente."
  value       = data.aws_ami.ubuntu.id
}

output "instancias_creadas" {
  description = "IDs de las instancias creadas con count."
  value       = aws_instance.web[*].id
}

output "nombres_instancias" {
  description = "Nombres asignados a cada instancia."
  value       = [for instance in aws_instance.web : instance.tags.Name]
}
