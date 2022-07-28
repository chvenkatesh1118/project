
 resource "aws_ecs_service" "ecsservice" {

   launch_type     = "EC2"
   task_definition = aws_ecs_task_definition.taskdef.arn
   cluster         = aws_ecs_cluster.ecscluster.id
   name            = "ecsservice"
   desired_count   = 1
   iam_role        = aws_iam_role.chantiecsrole.arn
#   depends_on      = [aws_iam_role_policy.ec2policy.arn]
#   load_balancer =  aws_lb.lb.id

#   load_balancer {
#     target_group_arn = aws_lb_target_group.foo.arn
#     container_name   = "nginx"
#     container_port   = 8080
#   }


 }
