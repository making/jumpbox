output "default_key_name" {
  value = "${aws_key_pair.jumpbox_vms.key_name}"
}

output "private_key" {
  value     = "${tls_private_key.jumpbox_vms.private_key_pem}"
  sensitive = true
}

output "external_ip" {
  value = "${aws_eip.jumpbox_eip.public_ip}"
}

output "jumpbox_security_group" {
  value = "${aws_security_group.jumpbox_security_group.id}"
}

output "jumpbox_default_security_groups" {
  value = ["${aws_security_group.jumpbox_security_group.id}"]
}

output "subnet_id" {
  value = "${aws_subnet.jumpbox_subnet.id}"
}

output "az" {
  value = "${aws_subnet.jumpbox_subnet.availability_zone}"
}

output "vpc_id" {
  value = "${local.vpc_id}"
}

output "region" {
  value = "${var.region}"
}

output "jumpbox_name" {
  value = "${local.jumpbox_name}"
}

output "internal_cidr" {
  value = "${local.internal_cidr}"
}

output "internal_gw" {
  value = "${local.internal_gw}"
}

output "jumpbox_internal_ip" {
  value = "${local.jumpbox_internal_ip}"
}

output "jumpbox_iam_user_name" {
  value = "${aws_iam_user.jumpbox.name}"
}

output "jumpbox_iam_user_access_key" {
  value = "${aws_iam_access_key.jumpbox.id}"
}

output "jumpbox_iam_user_secret_key" {
  value = "${aws_iam_access_key.jumpbox.secret}"
}
