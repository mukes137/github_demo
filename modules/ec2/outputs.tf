output "mongodc_server_id" {
  value       = aws_instance.mongodb_server.id
}

output "express_server_id" {
  value       = aws_instance.express_server.id
}

output "admin_server_id" {
  value       = aws_instance.admin_server.id
}
