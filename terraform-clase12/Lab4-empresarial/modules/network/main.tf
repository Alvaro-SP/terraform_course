
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
