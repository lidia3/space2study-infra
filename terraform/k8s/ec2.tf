resource "aws_instance" "control_plane" {
  ami                         = var.ami_id
  instance_type               = var.control_plane_instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true


  tags = {
    Name = "${var.project_name}-control-plane"
  }
}

resource "aws_instance" "worker" {
  ami                         = var.ami_id
  instance_type               = var.worker_instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true


  tags = {
    Name = "${var.project_name}-worker"
  }
}
