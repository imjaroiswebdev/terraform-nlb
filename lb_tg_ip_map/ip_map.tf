variable "instace_ips" {
  type    = list(list(string))
  default = [["172.31.11.179", "172.31.32.49"], ["172.31.11.179"]]
}

variable "tg_keys" {
  type = list(string)
}

variable "lb_target_group" {
  type = any
}


output "target_group_arn" {
  description = "ALB Target Group ARN"
  value       = join(",", var.lb_target_group.*.arn) #join("", data.aws_lb_target_group.tg.*.arn)
}


data "aws_lb_target_group" "test" {
  depends_on = [var.lb_target_group]
  count      = length(var.tg_keys)
  arn        = element(var.lb_target_group.*.arn, count.index)
}

output "tg_arn" {
  value = data.aws_lb_target_group.test.*.arn
}


locals {
  count = length(var.tg_keys)
  pre_ip_tuple = flatten([
    # Using Elements filtering (Ref. https://www.terraform.io/language/expressions/for#filtering-elements)
    for tgIndex, tg in { for arnIndex, lb_tg_arn in data.aws_lb_target_group.test.*.arn : arnIndex => lb_tg_arn } : [
      for ipsIndex, ips in var.instace_ips : {
        for ip in ips :
        "${tg}.${ip}" => {
          target_group_arn = tg
          target_id        = ip
        }
      } if tgIndex == ipsIndex
    ]
  ])
  ip_tuple   = merge(local.pre_ip_tuple...)
  ip_map     = tomap(local.ip_tuple)
  depends_on = [var.lb_target_group]
}

output "ip_map" {
  value = local.ip_map
}

