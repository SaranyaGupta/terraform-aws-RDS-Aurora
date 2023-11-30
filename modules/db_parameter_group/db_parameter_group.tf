################################################################################
# DB Parameter Group
################################################################################
locals {
  create = var.create
  db_parameter_group_name      = var.db_parameter_group_name
}
resource "aws_db_parameter_group" "this" {
  count = local.create && var.create_db_parameter_group ? 1 : 0

  name        = local.db_parameter_group_name
  name_prefix = var.db_parameter_group_use_name_prefix ? "${local.db_parameter_group_name}-" : null
  description = var.db_parameter_group_description
  family      = var.db_parameter_group_family

  dynamic "parameter" {
    for_each = var.db_parameter_group_parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = try(parameter.value.apply_method, "immediate")
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
