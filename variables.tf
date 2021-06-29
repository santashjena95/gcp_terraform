variable "instance_name" {
  description = "The name of VM Instance"
  type        = string
  default     = "sles15sp1sap20"
}
variable "vm_zone" {
  description = "Zone location of VM Instance"
  type        = string
  default     = "us-east4-c"
}
