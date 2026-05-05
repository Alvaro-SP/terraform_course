output "usuarios_creados" {
  description = "Usuarios IAM creados."
  value       = { for key, user in aws_iam_user.team : key => user.name }
}

output "grupos_creados" {
  description = "Grupos IAM creados."
  value       = { for key, group in aws_iam_group.groups : key => group.name }
}
