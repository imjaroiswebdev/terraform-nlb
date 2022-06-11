locals {
 
  hc_keys = keys(var.hc_map)
  lm_keys = keys(var.listener_map)
  tg_keys = keys(var.tg_map)
}

/*
resource "aws_instance" "ec2" {
  ami = var.amitype
  key_name = "bt_keypair1"
  vpc_security_group_ids = ["sg-1900ce68"]
  subnet_id = "${element(var.subs,count.index)}"
  associate_public_ip_address = true
  instance_type = var.i_type
  availability_zone = "${element(var.azs,count.index)}"
  count = length(var.subs)
  user_data = "${file("install_apache.sh")}"

  tags = {
    Name = "${var.project}-${count.index}"
  }
  }

*/

resource "aws_lb" "test" {
  name               = "mynlb-2" #var.nlb
  internal           = true 
  load_balancer_type = var.lb_type
  subnets            = var.subs
  enable_deletion_protection = var.deletion_protection_enabled  
  tags = {
     name= "mynlb-2" 
    }
}

resource "aws_alb_target_group_attachment" "test" {
  count            = length(var.instance_list)
  target_group_arn = "${aws_lb_target_group.tg.0.arn}"
  target_id        = "${element(var.instance_list, count.index)}"
  port             = 80
}


/*
resource "aws_lb_target_group" "ntg" {
  name     = var.tg
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc
  target_type           = var.target_group_target_type
  deregistration_delay  = var.deregistration_delay
  health_check {
    interval            = 30
    port                = var.tg_port
    protocol            = var.tg_protocol
    healthy_threshold   = 3
    unhealthy_threshold = 3
    }
}

*/

/*
resource "aws_lb_target_group_attachment" "ntg_attachment" {
  depends_on = [aws_instance.ec2]
  target_group_arn = "${aws_lb_target_group.ntg.arn}"
  count = length(var.azs)
  target_id        = element(aws_instance.ec2.*.private_ip,count.index)
  port             = 80
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "8080"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ntg.arn}"
  }
}
*/
