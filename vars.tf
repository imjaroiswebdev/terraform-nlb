variable "lb_type" {
  type = string
  }

variable "sgs" {
  type = list
  }

variable "subs" {
  type = list
  }

variable "vpc" {
  type = string
  }

variable "tg" {
  type        = any
  default     = []
  }


variable "tg_protocol" {
  type = string
  }

variable "tg_port" {
type = string
  }

variable "tg_type" {
  type = string
  }

variable "region" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."  
}

variable "amitype" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "ami-0022f774911c1d690"
  }


variable "i_type" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  default = "t2.micro"
  }


variable "project" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
  }

variable "azs" {
  type = list
  default = ["us-east-1a", "us-east-1b","us-east-1c"]
  }

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}


variable "target_group_target_type" {
  description = "Target type of target group"
  type        = string
  default     = "ip"
}
variable "deletion_protection_enabled" {
  description = "A boolean flag to enable/disable deletion protection for Load Balancer"
  type        = bool
  default     = false
}

variable "deregistration_delay" {
  description = "The amount of time to wait in seconds before changing the state of a deregistering target to unused"
  type        = number
  default     = 15
}

/*
variable "security_groups" {
  description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}
variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = string
  default     = null
}
*/

variable "hc_map" {
  description = "health check map"
  type        = map(map(string))
}

variable "listener_map" {
  description = "listener map"
  type        = map(map(string))
} 


variable "listener_map_count" {
  description = "The number of listener maps to utilize"
  type        = number
  default     = 1
}


variable "tg_map" {
  description = "target group map"
  type        = map(map(string))
}

variable "name" {
  description = "name"
  type        = string
  default     = "test"
}


variable "instance_list" {
  description = "name"
  type        = any
}


