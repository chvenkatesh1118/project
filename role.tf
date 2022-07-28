resource "aws_iam_role" "chantiecsrole" {
  name = "ecsrole"

  assume_role_policy = <<EOF
{
 "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecspolicy" {
  name        = "ecs_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "ecs:*",

        "Resource" : "*"
      },
    ]
  })
}

resource "aws_iam_policy" "cloudpolicy" {
  name        = "cloudpolicy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({

    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "cloudformation:*",
        "Resource" : "*"
      }
    ]
  })
}
resource "aws_iam_policy" "ec2policy" {
  name        = "ec2policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({

    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "ec2:*",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "elasticloadbalancing:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "cloudwatch:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "autoscaling:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:CreateServiceLinkedRole",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "iam:AWSServiceName" : [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      },
    ]
  })
}





resource "aws_iam_role_policy_attachment" "ecs-attach" {
      role       = aws_iam_role.chantiecsrole.name
      policy_arn = aws_iam_policy.ecspolicy.arn

}
resource "aws_iam_role_policy_attachment" "ec2-attach" {
  role       = aws_iam_role.chantiecsrole.name
  policy_arn = aws_iam_policy.ec2policy.arn

}
resource "aws_iam_role_policy_attachment" "cloud-attach" {
  role       = aws_iam_role.chantiecsrole.name
  policy_arn = aws_iam_policy.cloudpolicy.arn

}


resource "aws_lb" "lb" {
  name               = "lb"
  internal           = false
  load_balancer_type = "application"
#  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.subnet1.id

  enable_deletion_protection = true


  tags = {
    Environment = "production"
  }
}