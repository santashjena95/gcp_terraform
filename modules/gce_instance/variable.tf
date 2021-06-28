variable "internal_ip_name" {
  type        = string
}
variable "network_name" {
  type        = string
}
variable "subnetwork_name" {
  type        = string
}
variable "internal_ip_address" {
  type        = string
}
variable "vm_region" {
  type        = string
}
variable "instance_name" {
  description = "The name of VM Instance"
  type        = string
}
variable "vm_machine_type" {
  description = "Machine type of VM Instance"
  type        = string
  default     = "e2-small"
}
variable "vm_zone" {
  description = "Zone location of VM Instance"
  type        = string
  default     = "us-east4-c"
}
variable "vm_image" {
  description = "Image to be used for Boot disk OS"
  type        = string
  default = "projects/pelagic-magpie-308310/global/images/sles15sp1sapnew"
}
variable "service_account" {
  type        = string
}
variable "startup_script" {
  type        = string
}
