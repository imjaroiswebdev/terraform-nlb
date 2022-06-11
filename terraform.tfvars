#nlb = "terraform-network-load-balancer"
name = "test nlb"
azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
lb_type = "network"
sgs = ["sg-0fdc9c8c32c542bfd"]
subs = ["subnet-558e210f","subnet-65dcd200","subnet-e0f147cc"]
#target_ids [["172.31.11.179","172.31.32.49"`],["172.31.11.179"],["172.31.70.255"]]

instance_list = ["172.31.11.179","172.31.32.49"]
vpc = "vpc-fabc0983"
tg = "aws-target-group-1"
tg_protocol = "TCP"
tg_port = 80
tg_type = "instance"
region = "us-east-1"
amitype = "ami-0022f774911c1d690"
project = "first ec2 demo"
i_type = "t2.micro"

hc_map = {
listener1 = {
  protocol= "TCP"
  healthy_threshold= 3
  unhealthy_threshold = 3
  interval= 30
}
 
listener2 = {
  protocol= "TCP"
  healthy_threshold= 3
  unhealthy_threshold = 3
  interval= 30
 }
}
 
listener_map_count = 2
 
listener_map = {
listener1 = {
  port = 80
}
 
listener2 = {
  port= 443
}
}
 
# if `name` is not defined, then the map index is used for this value

tg_map = {
listener1 = {
  name  = "listener1-tg-name"
  port  = 80
  dereg_delay = 300
  target_type = "ip"
}
 
listener2 = {
  name  = "listener2-tg-name"
  port  = 443
  dereg_delay = 300
  target_type = "ip"
}
}
