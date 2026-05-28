
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
