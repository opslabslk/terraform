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
