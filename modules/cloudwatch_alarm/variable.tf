variable "db_instance_id" {
  type        = string
  description = "RDS Instance ID"
}

variable "alarm_name" {
  type        = string
  description = "Alarm Name Prefix"
}
variable "CPU_threshold" {
  type        = number
  default     = 80
  description = "The value against which the specified statistic is compared."
}
variable "Memory_threshold" {
  type        = number
  default     = 4000
  description = "The value against which the specified statistic is compared."
}
variable "storage_threshold" {
  type        = number
  default     = 20480
  description = "The value against which the specified statistic is compared."
}
variable "evaluation_period" {
  type        = string
  default     = "5"
  description = "The evaluation period over which to use when triggering alarms."
}
variable "alarm_description" {
  type        = string
  default     = ""
  description = "Alarm description"
}
variable "statistic_period" {
  type        = string
  default     = "60"
  description = "The number of seconds that make each statistic period."
}
/*
variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold."
  sensitive   = true
}

variable "namespace" {
  type        = string
  default     = "AWS/EC2"
  description = "The namespace for the alarm's associated metric."
  sensitive   = true
}
variable "metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "The name for the alarm's associated metric."
}
*/
variable "period" {
  type        = number
  default     = 120
  description = "The period in seconds over which the specified statistic is applied."
}
variable "create_high_cpu_alarm" {
  type        = bool
  default     = true
  description = "Whether or not to create the high cpu alarm.  Default is to create it (for backwards compatible support)"
}
variable "create_memory_too_low_alarm" {
  type        = bool
  default     = true
  description = "Whether or not to create the memory_too_low_alarm.  Default is to create it (for backwards compatible support)"
}
variable "create_storage_space_too_low_alarm" {
  type        = bool
  default     = true
  description = "Whether or not to create the storage_space_too_low_alarm  Default is to create it (for backwards compatible support)"
}

variable "actions_alarm" {
  type        = list
  default     = []
  description = "A list of actions to take when alarms are triggered. Will likely be an SNS topic for event distribution."
}

variable "actions_ok" {
  type        = list
  default     = []
  description = "A list of actions to take when alarms are cleared. Will likely be an SNS topic for event distribution."
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to each alarm"
}

variable "db_instance_class" {
  type      = string
  description = "The rds instance class, e.g. db.t3.medium"
}
