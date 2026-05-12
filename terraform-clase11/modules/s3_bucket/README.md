# S3 Bucket Module

## Descripcion
Modulo de terraform para crear y configurar un bucket de S3 en AWS, de forma reutilizable y parametrizada.

## Requisitos
- Terraform >= 1.0
- Providers AWS configurado

## Inputs
| Name           | Description                         | Type   | Default | Required |
|----------------|-------------------------------------|--------|---------|:--------:|
| bucket_name   | Nombre del bucket de S3              | string | n/a     |   yes    |
| environment   | Entorno de despliegue (dev, prod)    | string | "dev"   |   no     |

## Outputs
| Name           | Description                         |
|----------------|-------------------------------------|
| bucket_name     | Nombre del bucket de S3 creado         |
| bucket_arn     | ARN del bucket de S3 creado         |

## Ejemplo de uso
```hcl
module "my_bucket" {
  source = "./modules/s3_bucket"
  
  bucket_name = "my-app-bucket"
  environment = "prod"
}
```

## Notas
