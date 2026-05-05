resource "aws_iam_user" "team" {
    for_each = var.users

    name = "${var.project_name}-${each.key}" #terraform-clase9-alvaro

    tags = {
        Name  = each.key
        Role  = each.value.role
        Group = each.value.group
        Clase = "9"
        Lab   = "for_each-iam"
    }
}

locals {
    unique_groups = toset([for user in values(var.users) : user.group])
}

resource "aws_iam_group" "groups" {
    for_each = local.unique_groups
    name = "${var.project_name}-${each.key}"
}

resource "aws_iam_user_group_membership" "membership" {
    for_each = var.users

    user = aws_iam_user.team[each.key].name

    groups = [
        aws_iam_group.groups[each.value.group].name
    ]
}
