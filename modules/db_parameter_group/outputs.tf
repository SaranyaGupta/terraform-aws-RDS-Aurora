################################################################################
# DB Parameter Group
################################################################################

output "db_parameter_group_arn" {
  description = "The ARN of the DB parameter group created"
  value       = try(aws_db_parameter_group.this[0].arn, null)
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group created"
  value       = try(aws_db_parameter_group.this[0].id, null)
}