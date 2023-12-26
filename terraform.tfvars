create = true
name   ="rds-aurora-mysql-test"
tags   = {
      ServerRoleType             = "Application"
      ServiceCriticality         = "High"
  }
manage_master_user_password  = true
create_db_subnet_group=true
db_subnet_group_name="db-rds-subnet"
subnets =["subnet-0b86a94123ccf1094","subnet-04eff055558594bd7","subnet-0bbf1e60c1a0f1db1"]
allocated_storage =2
backup_retention_period = 7
backtrack_window = 259200
database_name ="testdb"
db_cluster_instance_class ="db.r6g.large"
enabled_cloudwatch_logs_exports=["error"]
engine="aurora-mysql"
engine_version="8.0.mysql_aurora.3.03.1"
final_snapshot_identifier=null
master_username= "root"
preferred_backup_window="02:00-03:00"
preferred_maintenance_window="sun:05:00-sun:06:00"
cluster_tags={}
vpc_security_group_ids=["sg-0c5426001fd0fb679"]
db_parameter_group_name="test-db-parameter-group"
instance_class="db.r6g.large"
monitoring_role_arn="arn:aws:iam::215691912540:role/rds-monitoring-role"
iam_role_name="rds-aurora-monitoring-role"
autoscaling_max_capacity=2
autoscaling_min_capacity=0
autoscaling_policy_name="target-metric"
predefined_metric_type="RDSReaderAverageCPUUtilization"
autoscaling_scale_in_cooldown=300
autoscaling_scale_out_cooldown=300
autoscaling_target_cpu=70
autoscaling_target_connections=700
create_security_group=true
security_group_name="rds-sg5-aurora"
vpc_id="vpc-0419802ed12eec58a"
security_group_rules={
    "ingress" = { type = "ingress", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "For SSH" }
  }
security_group_tags={}
create_db_cluster_parameter_group=true
db_cluster_parameter_group_name="test-rds-aurora-parameter-group"
db_cluster_parameter_group_family="aurora-mysql8.0"
db_cluster_parameter_group_parameters=[]
create_db_parameter_group=true
db_parameter_group_family="aurora-mysql8.0"
db_parameter_group_parameters=[]
create_cloudwatch_log_group=true
cloudwatch_log_group_retention_in_days=7
CPU_threshold=80
Memory_threshold=4000
storage_threshold=20480
statistic="Average"
period=300
create_high_cpu_alarm=true
create_memory_too_low_alarm=true
create_storage_space_too_low_alarm=true
actions_alarm=["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
ok_alarm=["arn:aws:sns:us-east-2:215691912540:RDSAlarm"]
