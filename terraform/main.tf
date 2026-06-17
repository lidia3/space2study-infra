
resource "aws_instance" "app" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "space2study-app"
  }
}

output "public_ip" {
  value = aws_instance.app.public_ip
}

resource "aws_key_pair" "deployer" {
  key_name   = "space2study-key"
  public_key = file("~/.ssh/aws-space2study.pub")
}
