resource "aws_lb_listener" "listener" {
  count = var.listener_map_count
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = var.listener_map[element(local.lm_keys, count.index)]["port"]
  protocol = upper(
    lookup(
      var.listener_map[element(local.lm_keys, count.index)],
      "protocol",
      "TCP",
    ),
  )

  default_action {
    target_group_arn = lookup(
      var.listener_map[element(local.lm_keys, count.index)],
      "target_group",
      element(aws_lb_target_group.tg.*.arn, count.index),
    )
    type = "forward"
  }
}
