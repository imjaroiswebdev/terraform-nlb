resource "aws_lb_target_group" "tg" {
  count = length(local.tg_keys)

  vpc_id = var.vpc

  name = lookup(
    var.tg_map[element(local.tg_keys, count.index)],
    "name",
    "${var.name}-${element(local.tg_keys, count.index)}-tg",
  )

  deregistration_delay = lookup(
    var.tg_map[element(local.tg_keys, count.index)],
    "dereg_delay",
    "300",
  )
  port = var.tg_map[element(local.tg_keys, count.index)]["port"]
  protocol = upper(
    lookup(
      var.tg_map[element(local.tg_keys, count.index)],
      "protocol",
      "TCP",
    ),
  )
  target_type = lookup(
    var.tg_map[element(local.tg_keys, count.index)],
    "target_type",
    "instance",
  )

  health_check {
    healthy_threshold = lookup(
      var.hc_map[element(local.hc_keys, count.index)],
      "healthy_threshold",
      "3",
    )
    interval = lookup(
      var.hc_map[element(local.hc_keys, count.index)],
      "interval",
      "30",
    )
    port     = lookup(var.hc_map[element(local.hc_keys, count.index)], "port", "traffic-port")
    protocol = upper(var.hc_map[element(local.hc_keys, count.index)]["protocol"])
    unhealthy_threshold = lookup(
      var.hc_map[element(local.hc_keys, count.index)],
      "unhealthy_threshold",
      "3",
    )
  }
}

