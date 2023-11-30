################################################################################
# DB Subnet Group
################################################################################

output "db_subnet_group_name" {
  description = "The db subnet group name"
  value       = module.db_subnet_group.db_subnet_group_name
}
output "db_cluster_parameter_group_name" {
  description = "The name of the DB cluster parameter group created"
  value       = module.cluster_parameter_group.db_cluster_parameter_group_name
}
output "db_parameter_group_name" {
  description = "The db parameter group name"
  value       = module.db_parameter_group.db_parameter_group_name
}