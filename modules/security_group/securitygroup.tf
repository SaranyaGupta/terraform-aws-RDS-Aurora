locals {
  name = var.security_rules

  flat_security_rules = merge([
      for new_sg, rules in var.security_rules:
         {
           for rule, vals in rules:
             "${new_sg}-${rule}" => merge(vals, {name = new_sg})
         }
    ]...) # please, do NOT remove the dots
}

resource "aws_security_group" "rds_security_groups" {
  for_each = local.name
  name   = each.key
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rules" {
  for_each          = local.flat_security_rules
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = aws_security_group.rds_security_groups[each.value.name].id
}