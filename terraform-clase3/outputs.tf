
output "vpc_id" {
    description = "Id de la VPC creada"
    value       = aws_vpc.main.id
}

output "public_subnet_id" {
    description = "Id de la subnet publica"
    value       = aws_subnet.public.id
}

output "instance_id" {
    description = "Id de la subnet publica"
    value       = aws_instance.web.id
}

output "instance_public_ip" {
    description = "Direccion IP Publica de la instancia"
    value       = aws_instance.web.public_ip
}

output "web_url" {
    description = "URL para acceder al servidor web"
    value       = "http://${aws_instance.web.public_ip}"
}

output "security_group_id" {
    description = "ID del Grupo de seguridad de mi infra"
    value       = aws_security_group.web.id
}