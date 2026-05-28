# ============================================================================
# MÓDULO HIJO: data
# ============================================================================
# RESPONSABILIDAD: RDS PostgreSQL + contraseña aleatoria
# RECIBE: vpc_id, private_subnet_ids, environment
# EXPONE: rds_id, rds_endpoint, rds_password (sensitive)
#
# 👉 LEER EN CLASE: "Este módulo crea recursos sensibles. Fíjense en
# `random_password`: en producción usaríamos `aws_db_instance` con
# contraseña encriptada por KMS, pero el patrón es el mismo: el módulo
# lo crea y lo expone como sensitive."
# ============================================================================

resource "random_id" "rds" {
  byte_length = 4
  prefix      = "rds-${var.environment}-"
}

resource "random_password" "rds_password" {
  length  = 16
  special = false
}
