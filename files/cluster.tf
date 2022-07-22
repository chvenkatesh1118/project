resource "aws_ecs_cluster" "ecscluster" {
  name = "ecscluster"

  setting {
    name  = "containerInsights"
    value = "enabled"

  }
}
resource "aws_ecs_cluster_capacity_providers" "providers" {
  cluster_name = aws_ecs_cluster.ecscluster.name

  capacity_providers = ["EC2"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 1
    capacity_provider = "EC2"
  }
}


resource "aws_ecs_capacity_provider" "EC2" {
  name = "EC2"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.autoscale.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 1
    }
  }
}


resource "aws_autoscaling_group" "autoscale" {
  max_size = 1
  min_size = 1
  mixed_instances_policy = false
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
