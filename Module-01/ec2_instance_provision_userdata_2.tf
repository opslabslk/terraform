# https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_group" "allow_http" {
  name        = "DMZ"
  description = "allow web traffic from internet"

  ingress {
    description = "name"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Type=All traffic protocol=	All	port range=All	destination=0.0.0.0/0	name
  egress {
    description = "name"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# ssh-keygen -f new_ssh_key
resource "aws_key_pair" "new_ssh_key" {
  key_name   = "new_ssh_key"
  public_key = "${file("new_ssh_key.pub")}"
}

# login command : ssh -i new_ssh_key ec2-user@3.15.183.41
# login command : ssh 3.15.183.41 -l ec2-user -i new_ssh_key

resource "aws_instance" "name" {
  ami             = "ami-0f7919c33c90f5b58"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.allow_http.name}"]
  key_name        = "${aws_key_pair.new_ssh_key.key_name}"
  user_data = "${file("userdata.sh")}"
}
