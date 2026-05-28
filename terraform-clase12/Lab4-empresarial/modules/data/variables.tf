variable "vpc_id" {
  type        = string
  description = "VPC donde se crea la RDS"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Subnets PRIVADAS — la RDS no debe estar en subnets públicas"
}

variable "environment" {
  type        = string
  description = "Ambiente"
}
