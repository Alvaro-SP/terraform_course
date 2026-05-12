

# utilizar la VPC default
data "aws_vpc" "default" {
    default = true
}

# genera varios bloques ingress en un mis SG
resource "aws_security_group" "web" {
    name = "dynamic-sg"
    description = "Security Group con ingress generado dinamicamente"
    vpc_id = data.aws_vpc.default.id

    dynamic "ingress" {
        for_each = var.allowed_ports
        content {
            description = "Puerto permitido ${ingress.value}"
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        description = "All outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name  = "dynamic-sg"
        Clase = "9"
        Lab   = "dynamic"
    }
}