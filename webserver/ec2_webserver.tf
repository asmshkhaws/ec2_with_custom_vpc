module "asim_vpc" {
    source      = "../module/vpc"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
}


resource "aws_key_pair" "asim_key" {
  key_name   = "asim_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "asim_instance" {
  ami                     = lookup(var.AMI, var.AWS_REGION)
  instance_type           = var.instance_type
  key_name                = aws_key_pair.asim_key.key_name
  # instance_count = var.ENVIRONMENT == "Production" ? 2 : 1
  subnet_id = module.asim_vpc.public_subnet1_id
  tags = {
    Name = "${var.ENVIRONMENT}-instance-01"
  }
  provisioner "file" {
      source = "installNginx.sh"
      destination = "/tmp/installNginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/installNginx.sh",
      "sudo sed -i -e 's/\r$//' /tmp/installNginx.sh",  # Remove the spurious CR characters.
      "sudo /tmp/installNginx.sh",
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

resource "aws_security_group" "asim_webservers"{
  tags = {
    Name = "${var.ENVIRONMENT}-asim-webservers"
  }
  
  name          = "${var.ENVIRONMENT}-asim-webservers"
  description   = "Created by Asim"
  vpc_id        = module.asim_vpc.my_vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
