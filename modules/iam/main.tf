resource "aws_iam_policy" "policy" {
  name        = "gamex_ec2__policy"
  path        = "/"
  description = "This is the policy for ec2"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "gamex_role" {
  name = "gamex-ec2-full-access-role-for-ec2"
  description = "this is the role for the use case of ec2"

assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        }
        Effect = "Allow"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.gamex_role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile_for_ec2"
  role = aws_iam_role.gamex_role.name
}