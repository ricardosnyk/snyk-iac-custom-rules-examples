provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "valid" {
  ami                         = "ami-005e54dee72cc1d00" 
  instance_type               = "t2.micro"
  associate_public_ip_address = false

}

resource "aws_instance" "invalid" {
  ami                         = "ami-005e54dee72cc1d00" 
  instance_type               = "t2.micro"
  associate_public_ip_address = true
}