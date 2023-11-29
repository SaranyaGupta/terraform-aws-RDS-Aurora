output "alarm_name1" {
  description = "The alarm name : CPU Utilization"
  value       = try(aws_cloudwatch_metric_alarm.cpu_utilization_too_high[*].alarm_name, null)
}
output "alarm_name2" {
  description = "The alarm name : Memory Utilization"
  value       = try(aws_cloudwatch_metric_alarm.memory_too_low[*].alarm_name, null)
}
output "alarm_name3" {
  description = "The alarm name : Storage Utilization"
  value       = try(aws_cloudwatch_metric_alarm.storage_space_too_low[*].alarm_name, null)
}