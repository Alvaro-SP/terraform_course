# ============================================================================
# MÓDULO HIJO: network
# ============================================================================
# RESPONSABILIDAD: VPC + subnets públicas + subnets privadas
# RECIBE: environment
# EXPONE: vpc_id, public_subnet_ids, private_subnet_ids
#
# 👉 LEER EN CLASE: "Este módulo solo conoce 'environment'. No tiene
# idea de qué app va encima ni qué base de datos hay después. Esa
# ignorancia es lo que lo hace reutilizable: el mismo módulo sirve para
# cualquier proyecto."
# ============================================================================

resource "random_id" "vpc" {
  byte_length = 4
  prefix      = "vpc-${var.environment}-"
}

resource "random_id" "subnet_public" {
  count       = 2
  byte_length = 4
  prefix      = "subnet-pub-"
}

resource "random_id" "subnet_private" {
  count       = 2
  byte_length = 4
  prefix      = "subnet-pri-"
}
