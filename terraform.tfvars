create_security_group                             =true
create_db_cluster_parameter_group                 =true
create_db_parameter_group                         =true
create_cloudwatch_log_group                       =true
create_high_cpu_alarm                             =true
create_memory_too_low_alarm                       =true
create_storage_space_too_low_alarm                =true
autoscaling_enabled                               =true
##Cloudwatch alarm name prefix format --> <cwa>-<rds>-<rds engine>-<App_Name>-<Environment>##
alarm_name                                        ="cwa-rds-aurora-mysql-test"
## mark true to "create" if want to create a rds cluster ##
create                                            = true
##RDS Cluster Name format --> <rds-cluster> -<App_Name>-<rds engine>-<Environment>-<Numeric> ##
name                                              ="rds-aurora-mysql-test"
manage_master_user_password                       = true
master_user_secret_kms_key_id                     =null
create_db_subnet_group                            =true
##SUBNET GROUP NAME format --> <rds-sg>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
db_subnet_group_name                              ="db-rds-subnet"
subnets                                           =["subnet-0b86a94123ccf1094","subnet-04eff055558594bd7","subnet-0bbf1e60c1a0f1db1"]
allocated_storage                                 = 2
backup_retention_period                           = 7
backtrack_window                                  = 259200
database_name                                     ="testdb"
db_cluster_instance_class                         ="db.r6g.large"
enabled_cloudwatch_logs_exports                   =["error"]
engine                                            ="aurora-mysql"
engine_version                                    ="8.0.mysql_aurora.3.03.1"
final_snapshot_identifier                         =null
master_username                                   = "root"
preferred_backup_window                           ="02:00-03:00"
preferred_maintenance_window                      ="sun:05:00-sun:06:00"
vpc_security_group_ids                            =["sg-0c5426001fd0fb679"]
## RDS Instance Name format --> <rds>-<App_Name>-<rds engine>-<Environment>-<Numeric>##
instances                                         = {
rds-aurora-mysql-test-1 = {}
rds-aurora-mysql-test-2 = {}
}
instance_class                                    ="db.r6g.large"
monitoring_role_arn                               ="arn:aws:iam::215691912540:role/rds-monitoring-role"
##MONITORING ROLE NAME FORMAT --> <role>-<aws-service>-<App-name>-<Environment>-<Functional-use>##
iam_role_name                                     ="rds-aurora-monitoring-role"
iam_role_description                              = null
autoscaling_max_capacity                          =2
autoscaling_min_capacity                          =0
autoscaling_policy_name                           ="target-metric"
predefined_metric_type                            ="RDSReaderAverageCPUUtilization"
autoscaling_scale_in_cooldown                     =300
autoscaling_scale_out_cooldown                    =300
autoscaling_target_cpu                            =70
autoscaling_target_connections                    =700
security_group_name                               ="rds-sg5-aurora"
security_group_description                        ="test security group for test RDS Aurora instance"
vpc_id                                            ="vpc-0419802ed12eec58a"
security_group_rules={
    "ingress" = { type = "ingress", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" }
  }
##CLUSTER PARAMETER GROUP NAME format --> <rds-cluster-pg>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
db_cluster_parameter_group_name                   ="rds-cluster-pg-aurora-mysql-test"
db_cluster_parameter_group_description            = "test RDS aurora parameter group name"
db_cluster_parameter_group_family                 ="aurora-mysql8.0"
db_cluster_parameter_group_parameters             =[]
##PARAMETER GROUP NAME format --> <rds-pg>_<App_Name>_<rds engine>_<Environment>_<Version>_<Numeric>##
db_parameter_group_name                           = "rds-pg-aurora-mysql-test"
db_parameter_group_description                    = "test RDS aurora parameter group name"
db_parameter_group_family                         ="aurora-mysql8.0"
db_parameter_group_parameters                     =[]
cloudwatch_log_group_kms_key_id                   = null
cloudwatch_log_group_retention_in_days            =7
CPU_threshold                                     =80
Memory_threshold                                  =4000
storage_threshold                                 =20480
statistic                                         ="Average"
period                                            =300
actions_alarm                                     =["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
ok_alarm                                          =["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
tags                                              = {
      ServerRoleType             = "Application"
      ServiceCriticality         = "High"
  }
cluster_tags={}
security_group_tags={}
##cluster IAM roles --> map(map(string))##
iam_roles = {}

##optional variables. default values mentioned in variable.tf file##
/*
auto_minor_version_upgrade
ca_cert_identifier
performance_insights_enabled
monitoring_interval
performance_insights_kms_key_id
performance_insights_retention_period
publicly_accessible
instance_timeouts
storage_type
cluster_timeouts
storage_encrypted
snapshot_identifier
skip_final_snapshot
port
network_type
kms_key_id
iops
iam_database_authentication_enabled
global_cluster_identifier
engine_mode
deletion_protection
copy_tags_to_snapshot
cluster_members
availability_zones
apply_immediately
allow_major_version_upgrade
source_region
is_primary_cluster
*/
