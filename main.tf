module "gce_instance_1" {
  source =            = "./modules/gce_instance"
  internal_ip_name    = "my-internal-test"
  network_name        = "test-vpc"
  subnetwork_name     = "new-us-east"
  internal_ip_address = "10.0.0.20"
  #vm_region           = ""
  instance_name       = "sles15sp1sap20"
  #vm_machine_type     = ""
  #vm_zone             = ""
  #vm_image            = ""
  service_account     = "terraform@industrial-pad-316908.iam.gserviceaccount.com"
  startup_script = <<SCRIPT
      #! /bin/bash
      sudo sed -i 's/.*127.0.1.1.*/${google_compute_address.internal_ip.address} ${var.instance_name}.personallab.local ${var.instance_name}/' /etc/hosts
      sudo hostnamectl set-hostname ${var.instance_name}
      echo ${var.domain_password} | kinit -V ${var.domain_user}@PERSONALLAB.LOCAL
      echo ${var.domain_password} | sudo realm join --verbose --user=${var.domain_user} PERSONALLAB.LOCAL
      sudo realm permit -g AccAdminSecOpsServers@PERSONALLAB.LOCAL
      sudo realm permit -g domain\ admins@PERSONALLAB.LOCAL
      sudo sed -i 's/use_fully_qualified_names = True/use_fully_qualified_names = False/g' /etc/sssd/sssd.conf
      sudo sh -c "echo 'entry_cache_timeout = 900' >> /etc/sssd/sssd.conf"
      sudo systemctl restart sssd.service
      sudo reboot
      SCRIPT
  shutdown_script = <<SCRIPT
      #! /bin/bash
      /home/jenasantash95/google-cloud-sdk/bin/gcloud compute instances remove-metadata ${var.instance_name} --zone=${var.vm_zone} --keys=startup-script,shutdown-script
      SCRIPT 
}
