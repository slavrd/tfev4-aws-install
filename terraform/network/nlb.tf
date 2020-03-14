resource "aws_lb" "ptfe" {
  name_prefix        = "ptfe-" # using hardcoded prefix because of length limitatoin to 6 chars
  load_balancer_type = "network"
  internal           = false
  subnets            = module.ptfe-network.public_subnet_ids
  tags               = var.common_tags
}

resource "aws_lb_listener" "port_80" {
  load_balancer_arn = aws_lb.ptfe.arn
  port              = 80
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port_80.arn
  }
}

resource "aws_lb_listener" "port_443" {
  load_balancer_arn = aws_lb.ptfe.arn
  port              = 443
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port_443.arn
  }
}

resource "aws_lb_listener" "port_8800" {
  load_balancer_arn = aws_lb.ptfe.arn
  port              = 8800
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port_8800.arn
  }
}

resource "aws_lb_target_group" "port_80" {
  name     = "${var.name_prefix}port-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = module.ptfe-network.vpc_id
}

resource "aws_lb_target_group" "port_443" {
  name     = "${var.name_prefix}port-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = module.ptfe-network.vpc_id
}

resource "aws_lb_target_group" "port_8800" {
  name     = "${var.name_prefix}port-8800"
  port     = 8800
  protocol = "TCP"
  vpc_id   = module.ptfe-network.vpc_id
}