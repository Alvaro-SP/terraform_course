
locals {

    # convertir nombres a mayus, de lista a lista
    upper_names = [for n in var.names : upper(n)]

    # de lista a map
    hostnames = { for n in var.names : n => "web-${n}"} #web-alvaro  #web-ana #web-carlos

    # Filtro: solo entornos de producción.
    prod_envs = [for e in var.envs : e if e.tier == "prod"]
    
    # convertir lista de objetos user a map, con filtro de activos
    active_users_map = {
        for u in var.users : u.name => u
        if u.active
    }
}