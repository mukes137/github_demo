variable "name" {
  description = "description"
  type        = string
  default     = "gamex"
}

variable "cidr" {
    description = "cidr block of the VPC"
    type        = string
    default     = ""
}

variable "public_subnet" {
  description = "cidr of the public subnet"
  type        = list(string)
  default     = []
}

variable "private_subnet" {
  description = "cidr for the private subnet"
  type        = string
  default     = ""
}

variable "az" {
  description = "availability zone for server"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}

