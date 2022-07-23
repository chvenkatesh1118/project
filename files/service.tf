
 resource "aws_ecs_service" "ecsservice" {

   launch_type     = "EC2"
   task_definition = aws_ecs_task_definition.taskdef.arn
   cluster         = aws_ecs_cluster.ecscluster.id
   name            = "ecsservice"
   desired_count   = 1
   iam_role        = aws_iam_role.chantiecsrole.arn
   #depends_on      = [aws_iam_role_policy.foo]


 }
