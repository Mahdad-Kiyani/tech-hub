provider "aws" {
  region = "eu-west-1"
}

resource "aws_emr_cluster" "data_pipeline_cluster" {
  name          = "data-pipeline-cluster"
  release_label = "emr-6.15.0"

  applications = ["Spark"]

  ec2_attributes {
    key_name                          = "your-key-name"
    subnet_id                         = "subnet-xxxxxxxx"
    emr_managed_master_security_group = "sg-xxxxxxxx"
    emr_managed_slave_security_group  = "sg-xxxxxxxx"
  }

  master_instance_group {
    instance_type = "m5.xlarge"
  }

  core_instance_group {
    instance_type  = "m5.xlarge"
    instance_count = 2
  }

  bootstrap_action {
    name = "Install dependencies"
    path = "s3://your-bootstrap-bucket/bootstrap.sh"
  }

  configurations_json = <<EOF
[
  {
    "Classification": "spark",
    "Properties": {
      "maximizeResourceAllocation": "true"
    }
  }
]
EOF

  service_role          = "EMR_DefaultRole"
  autoscaling_role      = "EMR_AutoScaling_DefaultRole"
  step_concurrency_level = 1

  log_uri = "s3://your-logs-bucket/emr-logs/"

  tags = {
    Project = "Data Engineering Pipeline"
  }
}

