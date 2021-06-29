resource "google_compute_network" "vpc_network_creation" {
  name                    = var.vpc_network
  mtu                     = 1460
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}
resource "google_compute_subnetwork" "vpc_subnet_creation" {
  name                     = var.vpc_subnet
  ip_cidr_range            = "192.168.0.0/24"
  region                   = "us-east4"
  private_ip_google_access = true
  network                  = google_compute_network.vpc_network_creation.id
}
