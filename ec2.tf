resource "tls_private_key" "technova" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "technova" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.technova.public_key_openssh

  tags = {
    Name = "${var.project_name}-key-pair"
  }
}

resource "local_file" "private_key" {
  content         = tls_private_key.technova.private_key_pem
  filename        = "${path.module}/../ansible/technova-key.pem"
  file_permission = "0600"
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = aws_key_pair.technova.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true

    tags = {
      Name = "${var.project_name}-root-volume"
    }
  }

  tags = {
    Name = "${var.project_name}-web-server"
  }
}
