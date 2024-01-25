locals {
  create = var.create
  port = var.port
  db_subnet_group_name          = var.db_subnet_group_name
  security_group_name           = var.security_group_name
  cluster_parameter_group_name  = var.db_cluster_parameter_group_name
  db_parameter_group_name       = var.db_parameter_group_name
  backtrack_window              = (var.engine == "aurora-mysql" || var.engine == "aurora")? var.backtrack_window : 0
  create_monitoring_role        = local.create && var.create_monitoring_role && var.monitoring_interval > 0
}
