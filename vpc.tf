resource "aws_vpc" "ecsvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ecsvpc"
  }
}


resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.ecsvpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "subnet1"
  }
}
