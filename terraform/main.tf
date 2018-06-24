provider "aws" {
  region = "${var.region}"
}

# terraform {
#   backend "s3" {
#     encrypt = "true"
#   }
# }

module "network" {
  source   = "./network"
  env      = "${var.env}"
  vpc_cidr = "10.0.0.0/16"
}

module "instance" {
  source            = "./instance"
  env               = "${var.env}"
  instance_type     = "${var.instance_type}"
  aws_subnet_id     = "${module.network.subnet_id}"
  key_name          = "${var.key_name}"
  security_group_id = "${module.network.security_group_id}"
}

module "dns" {
  source        = "./dns"
  env           = "${var.env}"
  instance_ip   = "${module.instance.instance_ip}"
  main_dns_name = "${var.main_dns_name}"
}

output "instance_dns" {
  value = "${module.instance.instance_dns}"
}
