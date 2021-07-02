resource "google_compute_address" "internal_ip" {
  name         = var.internal_ip_name
  subnetwork   = var.subnetwork_name
  address_type = "INTERNAL"
  address      = var.internal_ip_address
  region       = var.vm_region
}
resource "google_compute_instance" "instance_creation" {
  name         = var.instance_name
  machine_type = var.vm_machine_type
  zone         = var.vm_zone
  labels = { appname="test-terraform",environment="nonprod" }
  scheduling {
  preemptible  = true
  automatic_restart = false
  }
  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }
  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name
    network_ip = google_compute_address.internal_ip.address
    #access_config {
    #  // Ephemeral IP
    #}
  }
  metadata = {
    startup-script = var.startup_script
    shutdown-script = var.shutdown_script
  }
}
