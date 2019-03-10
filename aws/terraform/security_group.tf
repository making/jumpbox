resource "aws_security_group" "jumpbox_security_group" {
  name        = "${var.env_id}-jumpbox-security-group"
  description = "jumpbox"
  vpc_id      = "${local.vpc_id}"

  tags {
    Name = "${var.env_id}-jumpbox-security-group"
  }

  lifecycle {
    ignore_changes = ["name", "description"]
  }
}

resource "aws_security_group_rule" "jumpbox_security_group_rule_tcp_ssh" {
  security_group_id = "${aws_security_group.jumpbox_security_group.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jumpbox_security_group_rule_tcp_https" {
  security_group_id = "${aws_security_group.jumpbox_security_group.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jumpbox_security_group_rule_tcp_http8443" {
  security_group_id = "${aws_security_group.jumpbox_security_group.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8443
  to_port           = 8443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jumpbox_security_group_rule_tcp_mbus" {
  security_group_id = "${aws_security_group.jumpbox_security_group.id}"
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 6868
  to_port           = 6868
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jumpbox_security_group_rule_allow_internet" {
  security_group_id = "${aws_security_group.jumpbox_security_group.id}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
