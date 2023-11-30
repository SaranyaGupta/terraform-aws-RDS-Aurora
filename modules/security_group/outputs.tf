output "id" {
  value = [for s in aws_security_group.rds_security_groups : s.id]
}