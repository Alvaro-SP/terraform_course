terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "~> 2.4"
        }
    }
}
# un recurso siempre tiene 2 partes, el tipo y el nombre 
resource "local_file" "hola_terraform" {
    content = " Hola desde Terraform! "
    filename = "${path.module}/output/hola.txt"
}