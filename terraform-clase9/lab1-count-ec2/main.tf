
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web" {
  name        = "${var.project_name}-count-web-sg"
  description = "Security Group demo para EC2 con count"
  vpc_id      = data.aws_vpc.default.id

  # Permitimos HTTP para demo.
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Salida libre hacia internet.
  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.project_name}-count-web-sg"
    Clase = "9"
    Lab   = "count"
  }
}

resource "aws_instance" "web" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name  = "${var.project_name}-web-${count.index + 1}"
    Clase = "9"
    Lab   = "count"
  }
}
