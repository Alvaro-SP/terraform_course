
output "bucket_name" {
    description = "Nombre del bucket s3"
    value = module.s3_bucket.s3_bucket_id
}
output "bucket_arn" {
    description = "ARN del bucket s3"
    value = module.s3_bucket.s3_bucket_arn
}