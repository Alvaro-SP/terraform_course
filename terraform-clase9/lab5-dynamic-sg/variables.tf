variable "aws_region" {
  description = "Región AWS."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre base para el Security Group."
  type        = string
  default     = "terraform-clase9"
}
variable "allowed_ports" {
    type = list(number)
    default = [22, 80, 443]
}