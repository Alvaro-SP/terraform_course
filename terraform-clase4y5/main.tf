
# RECURSOS PRINCIPALES 
# META ARGUMENTOS Y TODA LA LOGICA

# EJEMPLO 1: bucket principal

resource "aws_s3_bucket" "bucket_principal" {
    count = var.crear_bucket_principal ? 1 : 0

    bucket = "${local.nombre_prefijo}-principal" #(mi-app-produccion-principal)

    # meta argumento "lifecycle"
    lifecycle {
        prevent_destroy = false
        ignore_changes = [
            server_side_encryption_configuration
        ]
    }

    tags = merge(
        local.etiquetas_estandar,
        {
            Nombre = "bucket-principal"
            Descripcion = "Bucket principal"
        }
    )
}

# EJEMPLO 2 Meta-argumento "count"
# - aws_s3_bucket.buckets_con_count[0] - primera instancia
# - aws_s3_bucket.buckets_con_count[1] - segunda instancia
# - aws_s3_bucket.buckets_con_count[*].id - Todos los ids

resource "aws_s3_bucket" "buckets_con_count" {
    count = var.cantidad_buckets

    bucket = "${local.nombre_prefijo}-count-${count.index + 1}" #mi-app-produccion-count-[X]

    tags = merge(
        local.etiquetas_estandar,
        {
            Nombre = "bucket-count-${count.index + 1}"
            Indice = tostring(count.index)
            Total = tostring(var.cantidad_buckets)
            Descripcion = "Bucket creado con count"
        }
    )
}

# EJEMPLO 3: Meta Argumentos "for_each"

# cuando quiero iterar un map y crear un recurso por cada elemento
# mas flexible que count y permite acceder por clave
resource "aws_s3_bucket" "buckets_con_foreach" {
    for_each = var.buckets_por_ambiente
    # Interpolacion con for_each
    # each.key ="desarrrolo", "testing", "produccion"
    # each.value = "app-dev-bucket"...
    bucket = "${each.value}-${var.ambiente}"

    tags = merge(
        local.etiquetas_estandar,
        {
        Nombre      = "bucket-foreach-${each.key}"
        AmbienteKey = each.key
        AmbienteVal = each.value
        Descripcion = "Bucket creado con for_each"
        }
    )
}

# EJEMPLO 4
# versionamiento de buckets con count
# depends_on = sirve para esperar que se creen otros recursos
resource "aws_s3_bucket_versioning" "buckets_versioning" {
    count = var.habilitar_versioning ? var.cantidad_buckets : 0
    bucket = aws_s3_bucket.buckets_con_count[count.index].id

    versioning_configuration {
        status = "Enabled"
    }

    depends_on = [aws_s3_bucket.buckets_con_count]

}

# EJEMPLO 5 Policy de bucket con for_each
resource "aws_s3_bucket_public_access_block" "buckets_versioning" {
    for_each = aws_s3_bucket.buckets_con_foreach
    bucket = each.value.id

    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true

    depends_on = [aws_s3_bucket.buckets_con_foreach]

    lifecycle {
        prevent_destroy = false
    }

}

# EJEMPLO 6 RECURSOS CONDICIONALES
resource "aws_s3_bucket" "bucket_condicional" {
    count = var.crear_recursos_adicionales && var.cantidad_buckets > 2 ? 1 : 0
    bucket = "${local.nombre_prefijo}-condicional"
    tags = merge(
        local.etiquetas_estandar,
        {
        Nombre      = "bucket-condicional"
        Descripcion = "Bucket condicional"
        }
    )
}

  
resource "aws_db_instance" "aplicacion" {
  # Información pública (no sensible)
  identifier            = "${local.nombre_prefijo}-db"
  engine                = "postgres"
  engine_version        = "15"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  username              = var.db_username
  password              = var.db_password
  
  # Configuración de backup
  backup_retention_period      = 7
  backup_window               = "03:00-04:00"
  maintenance_window          = "sun:04:00-sun:05:00"
  
  # Configuración de seguridad
  publicly_accessible         = false
  skip_final_snapshot         = true
  
  tags = merge(
    local.etiquetas_estandar,
    {
      Nombre   = "base-datos-aplicacion"
      Tipo     = "PostgreSQL"
      Sensible = "Sí - Credenciales"
    }
  )
}
