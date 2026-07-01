resource "aws_instance" "agent" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "space2study-agent"
  }
}

resource "aws_instance" "frontend" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t3.small"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "space2study-frontend"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "space2study-backend"
  }
}

resource "aws_instance" "database" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "space2study-database"
  }
}
resource "aws_key_pair" "deployer" {
  key_name   = "space2study-key"
  public_key = file("~/.ssh/aws-space2study.pub")
}
