resource "aws_ecs_cluster" "ecscluster" {
  name = "ecscluster"

  setting {
    name  = "containerInsights"
    value = "enabled"

  }
}
resource "aws_ecs_cluster_capacity_providers" "providers" {
  cluster_name = aws_ecs_cluster.ecscluster.name

  capacity_providers = "EC2"

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







resource "aws_launch_template" "launchtemplate" {
  name_prefix   = "launchtemplate"
  image_id      = "ami-0bb6af715826253bf"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "autoscale" {
  capacity_rebalance  = true
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.subnet1.id]

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 1
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.launchtemplate.id
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "1"
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "1"
      }
    }
  }
}
