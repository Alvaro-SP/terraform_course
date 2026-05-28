# ============================================================================
# Variables del root para el paso 2 — orquestación de módulos
# ============================================================================

variable "environment" {
  type    = string
  default = "dev"
}

variable "app_name" {
  type    = string
  default = "app"
}

