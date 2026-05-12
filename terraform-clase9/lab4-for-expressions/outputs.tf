output "upper_names" {
  description = "Lista de nombres convertidos a mayúsculas."
  value       = local.upper_names
}

output "hostnames" {
  description = "Map generado desde una lista."
  value       = local.hostnames
}

output "prod_envs" {
  description = "Entornos filtrados donde tier == prod."
  value       = local.prod_envs
}

output "active_users_map" {
  description = "Usuarios activos convertidos a map, ideal para for_each."
  value       = local.active_users_map
}
