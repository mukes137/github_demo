variable "ami_id" {
    description = "ami id to launch instance"
    type        = string
    default     = ""
}

variable "instance_type" {
    description = "instance size defined"
    type        = string
    default     = ""
}

 variable "key_name" {
   description = "key used to access the server"
   type        = string
   default     = ""
 }

 variable "security_group_id" {
    description = "security group id"
    type        = string
    default     = ""
}

variable "public_subnet_id" {
  description = "public subnet to launch instance"
  type        = list(string)
  default     = []
}

variable "private_subnet_id" {
  description = "private subnet to launch instance"
  type        = string
  default     = ""
}

variable "name" {
  description = "description of the variable"
  type        = string
  default     = "gamex"
}

variable "tags" {
  description = "tags for the instance"
  type        = map(string)
  default     = {}
}

variable "instance_profile" {}








 
 