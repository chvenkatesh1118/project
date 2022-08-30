provider "aws" {
region = "us-east-1"
}
resource "aws_instance"  "frontend"  {
  name = "${name}"
  ami           = "ami-077fb3e62ddf0fa9a"
 instance_type = "t2.micro"
 vpc_security_group_ids = ["sg-0a45fd04183d267bd"]

  tags = {
   Name = "frontend"
  }
}

variable "name" {

  default = "100"
}