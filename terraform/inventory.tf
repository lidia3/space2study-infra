resource "local_file" "ansible_inventory" {

  filename = "${path.module}/../ansible/native/inventory.ini"

  content = <<EOF
[agent]
${aws_instance.agent.public_ip}

[frontend]
${aws_instance.frontend.public_ip}

[backend]
${aws_instance.backend.public_ip}

[database]
${aws_instance.database.public_ip}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/Users/lidiareshnivetska/.ssh/aws-space2study
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# Private IPs (EC2 ↔ EC2 communication)
mongodb_host=${aws_instance.database.private_ip}
backend_private_ip=${aws_instance.backend.private_ip}
frontend_private_ip=${aws_instance.frontend.private_ip}

# Public IPs (Browser ↔ Application)
backend_public_ip=${aws_instance.backend.public_ip}
frontend_public_ip=${aws_instance.frontend.public_ip}
EOF

}
