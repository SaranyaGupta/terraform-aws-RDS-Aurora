resource "aws_db_parameter_group" "parameter_group" {
  count =  var.create ? 1 : 0
  name        = var.parameter_name
  description = var.description
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.parameter_name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}