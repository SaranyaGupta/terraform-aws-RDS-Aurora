################################################################################
# DB Parameter Group
################################################################################
variable "create" {
  description = "Whether cluster should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "create_db_parameter_group" {
  description = "Determines whether a DB parameter should be created or use existing"
  type        = bool
  default     = false
}

variable "db_parameter_group_use_name_prefix" {
  description = "Determines whether the DB parameter group name is used as a prefix"
  type        = bool
  default     = true
}
variable "db_parameter_group_name" {
  description = "The name of the parameter"
  type        = string
  default     = null
}
variable "db_parameter_group_description" {
  description = "The description of the DB parameter group. Defaults to \"Managed by Terraform\""
  type        = string
  default     = null
}

variable "db_parameter_group_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}

variable "db_parameter_group_parameters" {
  description = "A list of DB parameters to apply. Note that parameters may differ from a family to an other"
  type        = list(map(string))
  default     = []
}
