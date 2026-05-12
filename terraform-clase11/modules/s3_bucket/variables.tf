# INPUTS DEL MODULO
# Pensemos que son parametros de una funcion

variable "bucket_name" {
  description = "Nombre único del bucket S3"
  type        = string
}

variable "environment" {
  description = "Entorno donde se va a utilizar el bucket"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El environment debe ser dev, staging o prod."
  }
}