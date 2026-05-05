# ========================VARIBLES =======================
# VARIABLE 1: Tipo String (texto) con default
variable "proyecto" {
    type = string
    description = "Nombre del proyecto"
    default = "mi-app"

    validation {
        condition = length(var.proyecto) > 3
        error_message = "El nombre del proyecto debe tener mas de 3 caracteres."
    }
}

# VARIABLE 2: Tipo string pero sin default
variable "ambiente" {
  type        = string
  description = "Ambiente de despliegue (desarrollo, testing, produccion)"

  validation {
    condition     = contains(["desarrollo", "testing", "produccion"], var.ambiente)
    error_message = "El ambiente debe ser: desarrollo, testing, o produccion."
  }
}

# VARIABLE 3: tipo number (numeros)
variable "cantidad_buckets" {
    type = number
    description = "Cantidad de buckets s3 a crear con count"
    default = 3

    validation {
        condition = var.cantidad_buckets > 0 && var.cantidad_buckets <= 10
        error_message = "La cantidad debe estar entre 1 y 10"
    }
}

# VARIABLE 4: tipo bool
variable "habilitar_versioning" {
    type = bool
    description = "Habilitar versionamiento en buckets"
    default = true
}
variable "crear_bucket_principal" {
  type        = bool
  description = "Crear el bucket principal"
  default     = true
}

# VARIABLE 5: tipo List (arrays/listas)
variable "etiquetas_comunes" {
    type = list(string)
    description = "Lista de etiquetas a aplicar a todos los recursos"
    default = ["terraform","edutek","clase4y5"]
}

#VARIABLE 6: tipo map (diccionario/clave-valor)
variable "buckets_por_ambiente" {
    type = map(string)
    description = "Map de buckets por ambiente usando for_each"
    default = {
        desarrollo="app-dev-bucket"
        testing="app-test-bucket"
        produccion="app-prod-bucket"
    }
}

#VARIABLE 7: TIPO OBJETO (estructura compleja)
variable "configuracion_avanzada" {
    type = object({
        nombre = string
        puerto = number
        habilitado = bool
        caracteristicas = list(string)
        propiedades = map(string)
    })
    description = "Configuracion avanzada usando estructura compleja"
    default = {
        nombre = "aplicacion-principal"
        puerto = "8080"
        habilitado = true
        caracteristicas = ["autoscaling", "monitoreo", "logging"]
        propiedades = {
            version = "1.0"
            entorno = "cloud"
            framework = "terraform"
        }
    }
}

#8 variable de tipo LIST, compleja para guardar usuarios
variable "usuarios" {
  type = list(object({
    nombre = string
    email  = string
    activo = bool
  }))

  description = "Lista de usuarios con estructura compleja"

  default = [
    {
      nombre = "Alice"
      email  = "alice@example.com"
      activo = true
    },
    {
      nombre = "Bob"
      email  = "bob@example.com"
      activo = false
    }
  ]
}

# 9 para demostrar condicionales con COUNT
variable "crear_recursos_adicionales" {
  type        = bool
  description = "Crear recursos adicionales de prueba"
  default     = true
}
# 10 para demostrar el lifecycle
variable "permitir_destruccion" {
  type        = bool
  description = "Si es false, los recursos tendrán prevent_destroy=true"
  default     = false
}

variable "db_username" {
  type = string
  description = "usuario admin de la DB"
  sensitive = true
}

variable "db_password" {
  type = string
  description = "contrasenia de mi usuario admin de la DB"
  sensitive = true
}

# VARIABLES LOCALES (internas)
locals {
    nombre_prefijo = "${var.proyecto}-${var.ambiente}"
    etiquetas_estandar = {
        Proyecto = var.proyecto
        Ambiente = var.ambiente
        ManagedBy = "Terraform"
        Clase         = "Terraform-4y5"
        FechaCreacion = "2026-04-20"
    }
}