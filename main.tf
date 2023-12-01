provider "aws" {
  region = "us-east-2"
}

locals {
  create_db_subnet_group           = var.create_db_subnet_group
  create_db_parameter_group        = var.create_db_parameter_group
  create_cloudwatch_log_group      =var.create_cloudwatch_log_group
  create_db_cluster_parameter_group=var.create_db_cluster_parameter_group
  create                           = var.create
  port                             = var.port
}

module "rds_cluster" {
  source = "./modules/aurora-mysql"
  depends_on = [module.db_subnet_group.db_subnet_group_name]
  create                              = local.create
  name                                = var.name
  allocated_storage                   = var.allocated_storage
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = var.apply_immediately
  #availability_zones                  = var.availability_zones
  backup_retention_period             = var.backup_retention_period
  backtrack_window                    = var.backtrack_window
  cluster_use_name_prefix             = var.cluster_use_name_prefix
  cluster_members                     = var.cluster_members
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  database_name                       = var.is_primary_cluster ? var.database_name : null
  instance_class                      = var.instance_class
  #db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = "${module.cluster_parameter_group.db_cluster_parameter_group_name}"
  db_subnet_group_name                = "${module.db_subnet_group.db_subnet_group_name}"
  db_instance_parameter_group_name    = var.allow_major_version_upgrade ? var.db_instance_parameter_group_name : null
  db_parameter_group_name             = "${module.db_parameter_group.db_parameter_group_name}" 
  deletion_protection                 = var.deletion_protection
  enable_global_write_forwarding      = var.enable_global_write_forwarding
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  enable_http_endpoint                = var.enable_http_endpoint
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  final_snapshot_identifier           = var.final_snapshot_identifier
  global_cluster_identifier           = var.global_cluster_identifier
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  iops                         		    = var.iops
  kms_key_id                   		    = var.kms_key_id
  master_username                     = var.is_primary_cluster ? var.master_username : null
  network_type                        = var.network_type
  port                                = local.port
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  replication_source_identifier       = var.replication_source_identifier
  skip_final_snapshot                 = var.skip_final_snapshot
  snapshot_identifier                 = var.snapshot_identifier
  source_region                       = var.source_region
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  tags                                = var.tags
  #vpc_security_group_ids             = compact(concat([try(aws_security_group.this[0].id, "")], var.vpc_security_group_ids)) 
  vpc_security_group_ids              = var.vpc_security_group_ids
  cluster_timeouts ={
    create = try(var.cluster_timeouts.create, null)
    update = try(var.cluster_timeouts.update, null)
    delete = try(var.cluster_timeouts.delete, null)
  }
  ca_cert_identifier                    = var.ca_cert_identifier
  instances_use_identifier_prefix       = var.instances_use_identifier_prefix
  create_monitoring_role                = var.create_monitoring_role
  monitoring_role_arn                   = var.monitoring_role_arn
 instance_timeouts= {
    create = try(var.instance_timeouts.create, null)
    update = try(var.instance_timeouts.update, null)
    delete = try(var.instance_timeouts.delete, null)
  }
  iam_roles=var.iam_roles 
  iam_role_use_name_prefix=var.iam_role_use_name_prefix
  iam_role_description=var.iam_role_description
  iam_role_path=var.iam_role_path
  iam_role_managed_policy_arns   = var.iam_role_managed_policy_arns
  iam_role_permissions_boundary  = var.iam_role_permissions_boundary
  iam_role_force_detach_policies = var.iam_role_force_detach_policies
  iam_role_max_session_duration  = var.iam_role_max_session_duration
  cluster_tags=var.cluster_tags
  autoscaling_enabled=var.autoscaling_enabled
  autoscaling_max_capacity       = var.autoscaling_max_capacity
  autoscaling_min_capacity       = var.autoscaling_min_capacity
  autoscaling_policy_name               = var.autoscaling_policy_name
  autoscaling_scale_in_cooldown  = var.autoscaling_scale_in_cooldown
  autoscaling_scale_out_cooldown  = var.autoscaling_scale_out_cooldown
  predefined_metric_type=var.predefined_metric_type
  autoscaling_target_cpu =var.autoscaling_target_cpu 
  autoscaling_target_connections=var.autoscaling_target_connections
  create_cloudwatch_log_group=local.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id       = var.cloudwatch_log_group_kms_key_id
}
module "db_subnet_group" {
  source                 = "./modules/db_subnet_group"
  create                 = local.create
  create_db_subnet_group =var.create_db_subnet_group
  db_subnet_group_name   = var.db_subnet_group_name
  name                   = var.name
  subnets                = var.subnets
  tags                   = var.tags
}
module "cluster_parameter_group" {
  source = "./modules/db_cluster_parameter_group"
  create = local.create
  create_db_cluster_parameter_group      = local.create_db_cluster_parameter_group
  db_cluster_parameter_group_use_name_prefix = var.db_cluster_parameter_group_use_name_prefix
  db_cluster_parameter_group_name        =var.db_cluster_parameter_group_name
  db_cluster_parameter_group_description = var.db_cluster_parameter_group_description
  db_cluster_parameter_group_family      = var.db_cluster_parameter_group_family
  db_cluster_parameter_group_parameters= var.db_cluster_parameter_group_parameters
  tags = var.tags
}
module "db_parameter_group" {
  source = "./modules/db_parameter_group"
  create = local.create
  create_db_parameter_group      = local.create_db_parameter_group
  db_parameter_group_use_name_prefix = var.db_parameter_group_use_name_prefix
  db_parameter_group_name        =var.db_parameter_group_name
  db_parameter_group_description = var.db_parameter_group_description
  db_parameter_group_family      = var.db_parameter_group_family
  db_parameter_group_parameters  = var.db_parameter_group_parameters
  tags = var.tags
}