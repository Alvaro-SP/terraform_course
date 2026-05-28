
variable "vpc_id" {
  type        = string
  description = "VPC donde se despliega — viene de module.network.vpc_id"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets donde se crean las EC2 y el ALB"
}

variable "app_name" {
  type        = string
  description = "Nombre de la aplicación — usado en nombres de recursos"
  default     = "app"
}

variable "environment" {
  type        = string
  description = "Ambiente"
}
