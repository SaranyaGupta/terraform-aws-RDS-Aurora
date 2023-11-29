provider "aws" {
  region = "us-east-2"
}

locals {
  create_db_subnet_group    = var.create_db_subnet_group
  create_db_parameter_group = var.create_db_parameter_group
  create = var.create
  port = var.port
}

module "rds_cluster" {
  source = "./modules/aurora-mysql"
  count                               = local.create
  name                                = var.name
  allocated_storage                   = var.allocated_storage
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = var.apply_immediately
  availability_zones                  = var.availability_zones
  backup_retention_period             = var.backup_retention_period
  backtrack_window                    = var.backtrack_window
  cluster_use_name_prefix             = var.cluster_use_name_prefix
  cluster_members                     = var.cluster_members
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  database_name                       = var.is_primary_cluster ? var.database_name : null
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.create_db_cluster_parameter_group ?"${module.db_parameter_group.db_parameter_group_name[0]}" : var.db_cluster_parameter_group_name
  db_cluster_db_instance_parameter_group_name    = var.allow_major_version_upgrade ? var.db_cluster_db_instance_parameter_group_name : null
  db_subnet_group_name                = var.db_subnet_group_name
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
  tags                                = merge(var.tags, var.cluster_tags)
  #vpc_security_group_ids              = compact(concat([try(aws_security_group.this[0].id, "")], var.vpc_security_group_ids)) 

}
