output "bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = aws_s3_bucket.lab.bucket
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.lab.arn
}

output "bucket_region" {
  description = "Region donde fue creado el bucket"
  value       = aws_s3_bucket.lab.region
}
