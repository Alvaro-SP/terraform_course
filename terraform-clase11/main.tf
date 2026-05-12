# ROOT MODULE
# Aca no se van a crear los buckets directamente
# Este archivo va a consumir el modulo local

# bucket para logs
module "logs_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = "${var.project_name}-logs"
  environment = var.environment
}

# bucket para data
module "data_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = "${var.project_name}-data"
  environment = var.environment
}
