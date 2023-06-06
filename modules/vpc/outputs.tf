output "public-subnet-id" {
  description = "id of the private subnet"
  value       = aws_subnet.public[*].id
}

output "private-subnet-id" {
    description = "id of the  public subnet"
    value       = aws_subnet.private.id
}

output "vpc-id" {
    description = "id for the vpc"
    value       = aws_vpc.main.id
}

output "security-group-id" {
    description = "id for the securtiy group"
    value       = aws_security_group.main-sg.id
}