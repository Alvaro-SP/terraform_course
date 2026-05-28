# ============================================================================
# Variables del módulo network — su INTERFAZ DE ENTRADA
# ============================================================================
# 👉 LEER EN CLASE: "Esto es el 'contrato' del módulo: si me das estos
# valores, yo cumplo. Si declaras una variable acá, espera que te la pasen."

variable "environment" {
  type        = string
  description = "Ambiente (dev, staging, prod)"
}
