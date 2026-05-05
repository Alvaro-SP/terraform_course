
# valor simple string
output "nombre_proyecto" {
    value = var.proyecto
    description = "Nombre del proyecto"
}
output "ambiente" {
    value = var.ambiente
    description = "Ambiente de despliegue"
}
# acceso a atributos de recursos unicos (count=1)
output "bucket_principal_id" {
    value = try(aws_s3_bucket.bucket_principal[0].id, "No creado")
    description = "ID del bucket principal (si existiera)"
}
output "bucket_principal_arn" {
  value       = try(aws_s3_bucket.bucket_principal[0].arn, "No creado")
  description = "ARN del bucket principal"
}

# acceso a multiples recursos con count
output "buckets_count_ids" {
  value       = aws_s3_bucket.buckets_con_count[*].id
  description = "Lista de IDs de buckets creados con count"
}
output "buckets_count_arns" {
  value       = aws_s3_bucket.buckets_con_count[*].arn
  description = "Lista de ARNs de buckets creados con count"
}
output "buckets_count_total" {
    value = length(aws_s3_bucket.buckets_con_count)
    description = "Total de buckets creados con count"
}

output "db_username" {
  value =  aws_db_instance.aplicacion.username
  sensitive = true
}

output "db_password" {
  value =  aws_db_instance.aplicacion.password
  sensitive = true
}