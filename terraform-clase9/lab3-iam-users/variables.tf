variable "aws_region" {
  description = "Región de AWS. IAM es global, pero el provider requiere región."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefijo para identificar recursos del laboratorio."
  type        = string
  default     = "terraform-clase9"
}

variable "users" {
  description = "Usuarios IAM a crear. La clave del map será el nombre lógico del usuario."
  type = map(object({
    role  = string
    group = string
  }))

  default = {
    alvaro = {
      role  = "admin"
      group = "ops"
    }
    ana = {
      role  = "dev"
      group = "backend"
    }
    carlos = {
      role  = "viewer"
      group = "qa"
    }
  }
}
