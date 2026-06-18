output "agent_ip" {
  value = aws_instance.agent.public_ip
}

output "frontend_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_ip" {
  value = aws_instance.backend.public_ip
}

output "database_ip" {
  value = aws_instance.database.public_ip
}
