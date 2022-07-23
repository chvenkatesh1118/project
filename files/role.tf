resource "aws_iam_role" "chantiecsrole" {
  name = "ecs-role"

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
resource "aws_iam_role_policy_attachment"  "test-attach" {
  role       = aws_iam_role.chantiecsrole.name
  policy_arn = aws_iam_policy.ecspolicy.arn

}

resource "aws_iam_policy" "ecspolicy" {
  name        = "ecs_policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "ecs:*"
      },
      {

        "Effect" : "Allow",
        "Action" : "cloudformation:*",
        "Resource" : "*"
      },

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
    ]
  })
}







