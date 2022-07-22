
 resource "aws_ecs_service" "ecsservice" {
   name            = "ecsservice"
   cluster         = aws_ecs_cluster.ecscluster.id
   task_definition = aws_ecs_task_definition.taskdef.arn
   desired_count   = 3
   iam_role        = aws_iam_role.chantiecsrole.arn
   #depends_on      = [aws_iam_role_policy.foo]
   launch_type     = "EC2"

 }
