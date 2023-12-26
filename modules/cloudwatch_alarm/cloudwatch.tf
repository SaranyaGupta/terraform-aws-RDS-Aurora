resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
  count               = var.create_high_cpu_alarm ? 1 : 0
  alarm_name          = "HighCPUUsage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.CPU_threshold
  alarm_description   = "Alarm when CPU usage is above 80%"
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = [var.db_instance_id]
  }
}


resource "aws_cloudwatch_metric_alarm" "memory_too_low" {
  count               = var.create_memory_too_low_alarm ? 1 : 0
  alarm_name          = "freeable_memory_too_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.Memory_threshold
  alarm_description   = "Average database freeable memory too low"
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = [var.db_instance_id]
  }
}

resource "aws_cloudwatch_metric_alarm" "storage_space_too_low" {
 count                = var.create_storage_space_too_low_alarm ? 1 : 0
  alarm_name          = "Low-Free-Storage-Space"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = var.period
  statistic           = var.statistic_period
  threshold           = var.storage_threshold
  alarm_description   = "Average database free storage space too low"
  alarm_actions       = var.actions_alarm
  ok_actions          = var.actions_ok
  dimensions = {
    DBInstanceIdentifier = [var.db_instance_id]
  }
}
