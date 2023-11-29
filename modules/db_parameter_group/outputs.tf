output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = try(aws_db_parameter_group.parameter_group[*].id, null)
}

output "db_parameter_group_name" {
  description = "The db parameter group name"
  value       = try(aws_db_parameter_group.parameter_group[*].name, null)
}


output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = try(aws_db_parameter_group.parameter_group[*].arn, null)
}