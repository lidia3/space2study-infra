[control_plane]
CONTROL_PLANE_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-space2study

[worker]
WORKER_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/aws-space2study

[kubernetes:children]
control_plane
worker
