################################################################################
# DB Subnet Group
################################################################################

output "db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.db_subnet_group.db_subnet_group_name
}
output "db_cluster_parameter_group_name" {
  description = "The name of the DB cluster parameter group created"
  value       = try(aws_rds_cluster_parameter_group.this[0].name, null)
}
output "db_parameter_group_name" {
  description = "The db parameter group name"
  value       = try(aws_db_parameter_group.this[*].name, null)
}