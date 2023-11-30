locals {
    id = var.existing_sg_rules
    flat_security_rules = merge([
      for sg, rules in var.existing_sg_rules:
         {
           for rule, vals in rules:
             "${sg}-${rule}" => merge(vals, {id = sg})
         }
    ]...) # please, do NOT remove the dots
}
data "aws_security_group" "selected" {
  for_each = toset(var.sg_ids[*])
  id = each.value
}
resource "aws_security_group_rule" "rules" {
  for_each          = local.flat_security_rules
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  description       = each.value.description
  security_group_id = each.value.id
  }
  