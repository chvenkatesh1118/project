resource "aws_ecs_task_definition" "taskdef" {
  family = "taskdef"
  container_definitions = jsonencode([
    {
      name      = "nginx1"
      image     = "nginx:latest"
      cpu       = 1
      memory    = 350
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },


  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-1a]"
  }
}