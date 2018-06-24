variable "instance_type" {}
variable "aws_subnet_id" {}
variable "key_name" {}
variable "security_group_id" {}
variable "env" {}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners      = ["679593333241"]
  most_recent = true
}

resource "aws_instance" "ec2" {
  ami                         = "${data.aws_ami.centos.id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.aws_subnet_id}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
  associate_public_ip_address = true

  tags {
    Name = "desarrollo-${var.env}-instance"
  }
}

output "instance_dns" {
  value = "${aws_instance.ec2.public_dns}"
}

output "instance_ip" {
  value = "${aws_instance.ec2.public_ip}"
}
