
variable "instace_ips" {
  type    = list(list(string))
  default = [["172.31.11.179", "172.31.32.49"], ["172.31.11.179"]]
}


output "target_group_arn" {
  description = "ALB Target Group ARN"
  value       = join(",", aws_lb_target_group.tg.*.arn) #join("", data.aws_lb_target_group.tg.*.arn)
}


data "aws_lb_target_group" "test" {
  depends_on = [aws_lb_target_group.tg]
  count      = length(local.tg_keys)
  arn        = element(aws_lb_target_group.tg.*.arn, count.index)
}

output "tg_arn" {
  value = data.aws_lb_target_group.test
}


locals {
  pre_ip_tuple = flatten([
    # Using Elements filtering (Ref. https://www.terraform.io/language/expressions/for#filtering-elements)
    for tgIndex, tg in { for i, k in local.tg_keys : i => {
      arn        = data.aws_lb_target_group.test[i].arn
      target_key = k
      } } : [
      for ipsIndex, ips in var.instace_ips : {
        for ip in ips :
        "${tg.target_key}.${ip}" => {
          target_group_arn = tg.arn
          target_id        = ip
        }
      } if tonumber(tgIndex) == ipsIndex
    ]
  ])
  ip_tuple   = merge(local.pre_ip_tuple...)
  ip_map     = tomap(local.ip_tuple)
  depends_on = [aws_lb_target_group.tg]
}

output "ip_map" {
  value = local.ip_map
}

# aws_lb_target_group_attachment creation
resource "aws_lb_target_group_attachment" "clustera" {
  depends_on = [aws_lb_target_group.tg]
  for_each   = local.ip_map

  target_group_arn = each.value.target_group_arn
  target_id        = each.value.target_id
}

