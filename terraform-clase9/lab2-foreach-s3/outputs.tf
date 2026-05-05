output "bucket_names" {
  description = "Nombres reales de los buckets creados."
  value       = { for key, bucket in aws_s3_bucket.this : key => bucket.bucket }
}

output "bucket_arns" {
  description = "ARNs de los buckets creados."
  value       = { for key, bucket in aws_s3_bucket.this : key => bucket.arn }
}
