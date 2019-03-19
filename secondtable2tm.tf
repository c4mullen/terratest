

terraform {
  backend "s3"{
  bucket ="table2tms3"
  key = "terra/state"
  region = "ap-southeast-2"
  }
}

provider "aws" {
  alias = "ap-northeast-1"
  region = "ap-northeast-1"
}

provider "aws"
{
  alias = "ap-southeast-2"
  region = "ap-southeast-2"
}


resource "aws_instance" "table2tmfrontend" {
  depends_on = ["aws_instance.table2tmbackend"]
  provider="aws.ap-northeast-1"
  ami = "ami-02794be3fb6de50e1"
  instance_type = "t2.micro"
  key_name = "tombubbakey"
  tags = {
  Name = "user7frontend"
  }
  lifecycle{
    create_before_destroy = true
  }
}

resource "aws_instance" "table2tmbackend" {
  count = 2
  provider="aws.ap-southeast-2"
#  ami = "ami-02794be3fb6de50e1"
  ami = "ami-0789a5fb42dcccc10"
  instance_type = "t2.micro"
  key_name = "tombubbakey"
  tags = {
  Name = "user7tmbackend"
  }
  timeouts {
    create = "60m"
    delete = "2h"
  }
}
