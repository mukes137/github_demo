output "full_access_role" {
  value = aws_iam_role.gamex_role.arn
}

output "iam_instance_profile" {
    value = aws_iam_instance_profile.ec2_profile.name
}