variable "aws_region" {
  description = "Región de AWS donde se crearán las instancias."
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Cantidad de instancias EC2 idénticas que queremos crear con count."
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "Tipo de instancia EC2. Usar tamaños pequeños para demo."
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Nombre base para tags."
  type        = string
  default     = "terraform-clase9"
}
