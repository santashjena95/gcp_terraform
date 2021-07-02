#variable "vm_internal_ip" {
#  description = "Internal IP Address of VM Instance"
#  type        = string
#  default     = "10.0.0.20"
#}
variable "vm_region_name" {
  description = "Region location of VM Instance"
  type        = string
  default     = "us-east4"
}
variable "vm_instance_name" {
  description = "The name of VM Instance"
  type        = string
  default     = "sles15sp1sap20"
}
variable "vm_zone_name" {
  description = "Zone location of VM Instance"
  type        = string
  default     = "us-east4-c"
}
variable "domain_user" {
  type        = string
}
variable "domain_password" {
  type        = string
}
