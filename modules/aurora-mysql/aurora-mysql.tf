data "aws_partition" "current" {}

data "aws_availability_zones" "available" {}

resource "random_string" "database_password" {
  length  = 16
  special = false
 }

locals {
  create = var.create
  port = var.port
  db_subnet_group_name          = var.db_subnet_group_name
  security_group_name           = var.security_group_name
  cluster_parameter_group_name  = var.db_cluster_parameter_group_name
  db_parameter_group_name       = var.db_parameter_group_name
  backtrack_window              = (var.engine == "aurora-mysql" || var.engine == "aurora")? var.backtrack_window : 0
}

################################################################################
# Cluster
################################################################################

resource "aws_rds_cluster" "this" {
  count = local.create ? 1 : 0

  allocated_storage                   = var.allocated_storage
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = var.apply_immediately
  availability_zones                  = var.availability_zones
  backup_retention_period             = var.backup_retention_period
  backtrack_window                    = local.backtrack_window
  cluster_identifier                  = var.cluster_use_name_prefix ? null : var.name
  cluster_identifier_prefix           = var.cluster_use_name_prefix ? "${var.name}-" : null
  cluster_members                     = var.cluster_members
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  database_name                       = var.is_primary_cluster ? var.database_name : null
  db_cluster_instance_class           = var.db_cluster_instance_class
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name    = var.allow_major_version_upgrade ? var.db_cluster_db_instance_parameter_group_name : null
  db_subnet_group_name                = local.db_subnet_group_name
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
  iops                         		  = var.iops
  kms_key_id                   		  = var.kms_key_id
  master_password                     = var.is_primary_cluster ? random_string.database_password.result : null
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
  vpc_security_group_ids              = var.vpc_security_group_ids
  timeouts {
    create = try(var.cluster_timeouts.create, null)
    update = try(var.cluster_timeouts.update, null)
    delete = try(var.cluster_timeouts.delete, null)
  }

  depends_on = [aws_cloudwatch_log_group.this]
}

################################################################################
# Cluster Instance(s)
################################################################################

resource "aws_rds_cluster_instance" "this" {
  for_each = { for k, v in var.instances : k => v if local.create}

  apply_immediately                     = try(each.value.apply_immediately, var.apply_immediately)
  auto_minor_version_upgrade            = try(each.value.auto_minor_version_upgrade, var.auto_minor_version_upgrade)
  availability_zone                     = try(each.value.availability_zone, null)
  ca_cert_identifier                    = var.ca_cert_identifier
  cluster_identifier                    = aws_rds_cluster.this[0].id
  copy_tags_to_snapshot                 = try(each.value.copy_tags_to_snapshot, var.copy_tags_to_snapshot)
  db_parameter_group_name               = local.db_parameter_group_name
  db_subnet_group_name                  = local.db_subnet_group_name
  engine                                = var.engine
  engine_version                        = var.engine_version
  identifier                            = var.instances_use_identifier_prefix ? null : try(each.value.identifier, "${var.name}-${each.key}")
  identifier_prefix                     = var.instances_use_identifier_prefix ? try(each.value.identifier_prefix, "${var.name}-${each.key}-") : null
  instance_class                        = try(each.value.instance_class, var.instance_class)
  monitoring_interval                   = try(each.value.monitoring_interval, var.monitoring_interval)
  monitoring_role_arn                   = var.create_monitoring_role ? try(aws_iam_role.rds_enhanced_monitoring[0].arn, null) : var.monitoring_role_arn
  performance_insights_enabled          = try(each.value.performance_insights_enabled, var.performance_insights_enabled)
  performance_insights_kms_key_id       = try(each.value.performance_insights_kms_key_id, var.performance_insights_kms_key_id)
  performance_insights_retention_period = try(each.value.performance_insights_retention_period, var.performance_insights_retention_period)
  preferred_maintenance_window          = try(each.value.preferred_maintenance_window, var.preferred_maintenance_window)
  promotion_tier                        = try(each.value.promotion_tier, null)
  publicly_accessible                   = try(each.value.publicly_accessible, var.publicly_accessible)
  tags                                  = merge(var.tags, try(each.value.tags, {}))

  timeouts {
    create = try(var.instance_timeouts.create, null)
    update = try(var.instance_timeouts.update, null)
    delete = try(var.instance_timeouts.delete, null)
  }
}

################################################################################
# Cluster IAM Roles
################################################################################

resource "aws_rds_cluster_role_association" "this" {
  for_each = { for k, v in var.iam_roles : k => v if local.create }

  db_cluster_identifier = aws_rds_cluster.this[0].id
  feature_name          = each.value.feature_name
  role_arn              = each.value.role_arn
}

################################################################################
# Enhanced Monitoring
################################################################################

locals {
  create_monitoring_role = local.create && var.create_monitoring_role && var.monitoring_interval > 0
}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  count = local.create_monitoring_role ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  name        = var.iam_role_use_name_prefix ? null : var.iam_role_name
  name_prefix = var.iam_role_use_name_prefix ? "${var.iam_role_name}-" : null
  description = var.iam_role_description
  path        = var.iam_role_path

  assume_role_policy    = data.aws_iam_policy_document.monitoring_rds_assume_role[0].json
  managed_policy_arns   = var.iam_role_managed_policy_arns
  permissions_boundary  = var.iam_role_permissions_boundary
  force_detach_policies = var.iam_role_force_detach_policies
  max_session_duration  = var.iam_role_max_session_duration

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = local.create_monitoring_role ? 1 : 0

  role       = aws_iam_role.rds_enhanced_monitoring[0].name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

################################################################################
# Autoscaling
################################################################################

resource "aws_appautoscaling_target" "this" {
  count = local.create && var.autoscaling_enabled ? 1 : 0

  max_capacity       = var.autoscaling_max_capacity
  min_capacity       = var.autoscaling_min_capacity
  resource_id        = "cluster:${aws_rds_cluster.this[0].cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  tags = var.tags
}

resource "aws_appautoscaling_policy" "this" {
  count = local.create && var.autoscaling_enabled ? 1 : 0

  name               = var.autoscaling_policy_name
  policy_type        = "TargetTrackingScaling"
  resource_id        = "cluster:${aws_rds_cluster.this[0].cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type
    }

    scale_in_cooldown  = var.autoscaling_scale_in_cooldown
    scale_out_cooldown = var.autoscaling_scale_out_cooldown
    target_value       = var.predefined_metric_type == "RDSReaderAverageCPUUtilization" ? var.autoscaling_target_cpu : var.autoscaling_target_connections
  }

  depends_on = [
    aws_appautoscaling_target.this
  ]
}

################################################################################
# CloudWatch Log Group
################################################################################

# Log groups will not be created if using a cluster identifier prefix
resource "aws_cloudwatch_log_group" "this" {
  for_each = toset([for log in var.enabled_cloudwatch_logs_exports : log if local.create && var.create_cloudwatch_log_group && !var.cluster_use_name_prefix])

  name              = "/aws/rds/cluster/${var.name}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}
