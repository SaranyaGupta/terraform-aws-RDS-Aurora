locals {
  create                = var.create
  db_subnet_group_name  = var.db_subnet_group_name
}

resource "aws_db_subnet_group" "this" {
  count       = local.create && var.create_db_subnet_group ? 1 : 0
  name        = local.db_subnet_group_name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets
  tags        = var.tags
}