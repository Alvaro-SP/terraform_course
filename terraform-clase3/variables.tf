variable "aws_region" {
    description = "Region de AWS donde se va a desplegar la infraestructura"
    type        = string
    default     = "us-east-1"
}

variable "project_name" {
    description = "Nombre del proyecto (se va a utilizar en tags y en nombres de recursos)"
    type       = string
    default    = "edutek"
}

variable "vpc_cidr" {
    description = "CIDR block para la VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr"{
    description = "CIDR block para la subnet publica"
    type        = string
    default     = "10.0.0.0/24"
}

variable "instance_type" {
    description = "Tipo de instancia de nuestra EC2"
    type        = string
    default     = "t2.micro"
}