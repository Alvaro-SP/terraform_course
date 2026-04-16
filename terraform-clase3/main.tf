# ======================RECURSOS A CREAR==========================
#1 . Crear una VPC  - red privada virtual para mi infra
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support  = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.project_name}-vpc"
    }
}
#2 . Crear una Internet Gateway - para tenerr salida a internet
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.project_name}-igw"
    }
}
#3 . Crear una Subnet Publica
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr
    availability_zone = "${var.aws_region}a"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name}-public-subnet"
    }
}
#4 . Crear una Route Table - para enrutar la red (el trafico) y asociacion
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "${var.project_name}-public-rt"
    }
}
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}
#5 . Crear Security Group - mis reglas o mi firewall
resource "aws_security_group" "web" {
    name        = "${var.project_name}-web-sg"
    description = "Permitir SSH y HTTP"
    vpc_id      = aws_vpc.main.id

    # SSH desde cualquier IP en el ingress
    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # HTTP desde cualquier IP en el ingress
    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # HTTP desde cualquier IP en el ingress
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.project_name}-web-sg"
    }
}
#6 . Crear data source - para buscar la AMI mas reciente
data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

#7 . Crear la EC2 - mi server
resource "aws_instance" "web" {
    ami             = data.aws_ami.amazon_linux.id
    instance_type   = var.instance_type
    subnet_id       = aws_subnet.public.id
    vpc_security_group_ids  = [aws_security_group.web.id]
    user_data = <<-EOF
        #!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1> HOLA DESDE TERRAFORM - EDUTEK LATAM </h1>" > /var/www/html/index.html
        echo "<p> ID DE LA INSTANCIA : $(curl -s http://169.254.169.254/latest/meta-data/instance-id)<p>" >> /var/www/html/index.html
    EOF
    tags        = {
        Name = "${var.project_name}-web-server"
        Modified = "true"
        Environment = "clase3-lab"
    }

}
