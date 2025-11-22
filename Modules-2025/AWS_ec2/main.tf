resource "aws_security_group" "ec2_sg" {
  name        = "${var.name}-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_instance" "ec2" {
  count = length(var.subnet_ids)  
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = var.subnet_ids[count.index]
  key_name = var.key_name

  associate_public_ip_address = var.assign_public_ip

  tags = {
    Name = "${var.name}-ec2-instance-${count.index}"
  }
}