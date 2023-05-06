variable "ip_cidr_range" {
  description = "CIDR range for the subnet"
  type = string
}

variable "name" {
  description = "Name of the subnet"
  type = string
}

variable "network_id" {
  description = "ID of the network to create the subnet in"
  type = string
}

variable "region" {
  description = "Region to create the subnet in"
  type = string
}

variable "secondary_ip_ranges" {
  description = "Secondaries IP ranges to create in the subnet"
  type = list(object({
    range_name = string
    ip_cidr_range = string
  }))
  default = []
}
