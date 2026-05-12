variable "names" {
  description = "Lista simple para demostrar transformaciones."
  type        = list(string)
  default     = ["alvaro", "ana", "carlos"]
}

variable "envs" {
  description = "Lista de entornos para demostrar filtros."
  type = list(object({
    name = string
    tier = string
  }))

  default = [
    { name = "dev", tier = "non-prod" },
    { name = "qa", tier = "non-prod" },
    { name = "prod", tier = "prod" }
  ]
}
variable "users" {
    description = "Lista de usuarios para a map y filtro de activos"
    type = list(object({
        name = string
        role = string
        active = bool
    }))

    default = [
        { name = "alvaro", role = "admin" , active = true},
        { name = "ana", role = "dev", active = true },
        { name = "carlos", role = "viewer", active = false }
    ]
}