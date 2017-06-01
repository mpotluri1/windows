#EC2 Instance
terraform {
  backend "s3" {
    bucket = "manvi-logs"
    key = "suntrust-testing-terraform"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "suntrust_windows_stack" {
  ami = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.az}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.sg_instance.id}"]
  user_data = "${data.template_file.suntrust_bootstrap.rendered}"
  subnet_id = "${var.public_subnet}"
 iam_instance_profile = "${var.iamprofile}"
  root_block_device {
      volume_type = "gp2"
      volume_size = "100"
      delete_on_termination = "true"
  }
  ebs_block_device {
      device_name = "xvdf"
      volume_size = 100
      volume_type = "gp2"
      delete_on_termination = false
  }
  tags {
    Owner = "${var.owner}"
    Name = "${var.webserver_name}"
    ExpirationDate = "${var.expiration_date}"
    Environment = "${var.Environment}"
    Project = "${var.Project}"
  }
}

data "template_file" "suntrust_bootstrap" {
  template = "${file("user_data/sun.ps1")}"
}

resource "aws_security_group" "sg_instance" {
  name        = "sg_instance"
  description = "Allow all traffic within VPC"
  vpc_id = "${var.vpc_id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["${var.vpc_cidr_block}"]
  }
}