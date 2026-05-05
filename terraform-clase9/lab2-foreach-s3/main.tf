

resource "random_string" "suffix" {
    length = 6
    upper = false
    special = false
}

resource "aws_s3_bucket" "this" {
    for_each = var.buckets
    bucket = "${var.project_name}-${each.key}-${random_string.suffix.result}"

    tags = {
        Name       = "${var.project_name}-${each.key}"
        Clase      = "9"
        Lab        = "for_each"
        Versioned  = tostring(each.value.versioning)
        Retention  = tostring(each.value.days)
    }
}

resource "aws_s3_bucket_versioning" "this" {
    for_each = var.buckets

    bucket = aws_s3_bucket.this[each.key].id

    versioning_configuration {
        status = each.value.versioning ? "Enabled" : "Suspended"
    }
}

#lifecycle para retencion

resource "aws_s3_bucket_lifecycle_configuration" "this" {
    for_each = var.buckets

    bucket = aws_s3_bucket.this[each.key].id

    rule {
        id = "expire-objets-after-${each.value.days}-days"
        status = "Enabled"
        expiration {
            days = each.value.days
        }
    }
}