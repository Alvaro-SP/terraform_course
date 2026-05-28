
resource "random_id" "rds" {
  byte_length = 4
  prefix      = "rds-${var.environment}-"
}

resource "random_password" "rds_password" {
  length  = 16
  special = false
}
