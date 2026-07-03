resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file("~/.ssh/aws-space2study.pub")

  tags = {
    Name = "${var.project_name}-key"
  }
}
