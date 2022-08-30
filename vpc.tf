#resource "aws_vpc" "ecsvpc" {
#  cidr_block       = "10.0.0.0/16"
#  instance_tenancy = "default"
#
#  tags = {
#    Name = "ecsvpc"
#  }
#}
#
#
#resource "aws_subnet" "subnet1" {
#  vpc_id     = aws_vpc.ecsvpc.id
#  cidr_block = "10.0.0.0/24"
#
#  tags = {
#    Name = "subnet1"
#  }
#}
provider "aws" {
  region = "us-east-1"
}

resource "aws_ami" "example" {
  name                = "terraform-example"
  virtualization_type = "hvm"
  root_device_name    = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = "snap-xxxxxxxx"
    volume_size = 8
  }
}

resource "aws_instance" "jenkins" {
  aws_ami = "aws_ami.ami.id"
  instance_type = ""
  count = 1
  subnet_id = "aws_subnet.samplesubnet.id"
  aws_security_group_id = ""


}

tags = {
  Name = ""

}