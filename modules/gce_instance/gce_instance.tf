resource "google_compute_address" "internal_ip" {
  name         = var.internal_ip_name
  network      = var.network_name
  subnetwork   = var.subnetwork_name
  address_type = "INTERNAL"
  address      = var.internal_ip_address
  region       = "us-east4"
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
    network = google_compute_address.internal_ip.network
    subnetwork = google_compute_address.internal_ip.subnetwork
    network_ip = google_compute_address.internal_ip.address
    access_config {
      // Ephemeral IP
    }
  }
  metadata = {
    startup-script = var.startup_script
  }
}
