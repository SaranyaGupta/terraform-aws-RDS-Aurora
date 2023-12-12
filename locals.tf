locals {
  create_db_subnet_group           = var.create_db_subnet_group
  create_db_parameter_group        = var.create_db_parameter_group
  create_cloudwatch_log_group      =var.create_cloudwatch_log_group
  create_db_cluster_parameter_group=var.create_db_cluster_parameter_group
  create                           = var.create
  port                             = var.port
  create_high_cpu_alarm            = var.create_high_cpu_alarm
  create_storage_space_too_low_alarm= var.create_storage_space_too_low_alarm
  create_memory_too_low_alarm       = var.create_memory_too_low_alarm

}
