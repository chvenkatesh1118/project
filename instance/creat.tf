provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "instance" {
   ami           = "i-08f0aa11b0a26ef7a"
   instance_type  = "t2.micro"
   subnet_id   =  "subnet-0f42b250c3cf1d75c"

  count         = length(var.COMPONENTS)
   tags = {
      Name = var.COMPONENTS
    }
 }




