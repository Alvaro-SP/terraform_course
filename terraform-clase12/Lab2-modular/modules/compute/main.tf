# ============================================================================
# MÓDULO HIJO: compute
# ============================================================================
# RESPONSABILIDAD: EC2 + ALB + Security Group de la aplicación
# RECIBE: vpc_id, subnet_ids, app_name, environment
# EXPONE: instance_names, alb_dns, app_sg_id
#
# 👉 LEER EN CLASE: "Este módulo NO sabe cómo se creó la VPC. Solo
# recibe el vpc_id y confía en que existe. Esa es la magia de la
# composición: cada módulo es responsable de UNA cosa."
# ============================================================================

resource "random_pet" "ec2" {
  count  = 2
  length = 2
  prefix = "${var.app_name}-${var.environment}"
}

resource "random_id" "alb" {
  byte_length = 4
  prefix      = "alb-${var.app_name}-"
}

resource "random_id" "app_sg" {
  byte_length = 4
  prefix      = "sg-${var.app_name}-"
}
