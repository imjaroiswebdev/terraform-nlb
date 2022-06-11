module "lb_tg_ip_map" {
  source      = "./lb_tg_ip_map"
  instace_ips = [["172.31.11.179", "172.31.32.49"], ["172.31.11.179"]]
  tg_keys     = local.tg_keys
  lb_target_group = aws_lb_target_group.tg
}

# aws_lb_target_group_attachment creation
resource "aws_lb_target_group_attachment" "clustera" {
  depends_on = [module.lb_tg_ip_map.ip_map]
  for_each   = module.lb_tg_ip_map.ip_map

  target_group_arn = each.value.target_group_arn
  target_id        = each.value.target_id
}

