variable "aws_region" {
  description = "Región de AWS."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefijo base para los buckets. Debe ser corto y en minúsculas."
  type        = string
  default     = "tf-clase9"
}

variable "buckets" {
  description = "Map de buckets. Cada clave es el nombre lógico y cada valor contiene su configuración."
  type = map(object({
    versioning = bool
    days       = number
  }))

  default = {
    logs = {
      versioning = false
      days       = 30
    }
    backups = {
      versioning = true
      days       = 365
    }
    media = {
      versioning = true
      days       = 90
    }
  }
}
