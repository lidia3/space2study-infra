resource "local_file" "ansible_inventory" {

  filename = "${path.module}/../ansible/inventory.ini"

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
ansible_ssh_private_key_file=~/.ssh/aws-space2study
EOF

}
