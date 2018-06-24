variable "main_dns_name" {}

variable "instance_ip" {}

variable "env" {}

data "aws_route53_zone" "selected" {
  name         = "${var.main_dns_name}"
  private_zone = false
}

resource "aws_route53_record" "env_53_record" {
  name    = "${var.env}"
  type    = "A"
  ttl     = "300"
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  records = ["${var.instance_ip}"]
}
