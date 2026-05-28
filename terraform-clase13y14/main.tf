provider "aws" {
    region = "us-east-1"
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws" #NAMESPACE / NOMBRE-DEL-MODULO / PROVIDER
  
  version = "~> 4.0"

  bucket = "edutek-demo-terraform-registry-clase13"
#   acl    = "private" #modo privado por defecto
#   Practicas de seguridad
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  tags = {
    Environment = "demo"
    Course = "Clase 13y14"
    ManagedBy = "Terraform"
  }
}

resource "aws_s3_object" "archivo_demo" {
    bucket = module.s3_bucket.s3_bucket_id
    key = "demo/archivo.txt"
    source = "archivo.txt"
    storage_class = "STANDARD_IA"
}