

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
output "cluster_id" {
  description = "The RDS Cluster Identifier"
  value       = module.rds_cluster.cluster_id
}
output "instance_id" {
  description = "instances id"
  value       = module.rds_cluster.instance_id
}