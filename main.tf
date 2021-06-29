module "gce_instance_1" {
  source              = "./modules/gce_instance_linux"
  internal_ip_name    = "my-internal-test"
  network_name        = "test-vpc"
  subnetwork_name     = "new-us-east"
  internal_ip_address = var.vm_internal_ip
  vm_region           = var.vm_region_name
  instance_name       = var.vm_instance_name
  #vm_machine_type     = ""
  vm_zone             = var.vm_zone_name
  #vm_image            = ""
  service_account     = "terraform@industrial-pad-316908.iam.gserviceaccount.com"
  startup_script = <<SCRIPT
      #! /bin/bash
      sudo hostnamectl set-hostname ${var.vm_instance_name}
      sudo sed -i 's/.*127.0.1.1.*/${var.vm_internal_ip} ${var.vm_instance_name}.personallab.local ${var.vm_instance_name}/' /etc/hosts
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
      /home/jenasantash95/google-cloud-sdk/bin/gcloud compute instances remove-metadata ${var.vm_instance_name} --zone=${var.vm_zone_name} --keys=startup-script,shutdown-script
      SCRIPT 
}
module "gce_network_1" {
  source      = "./modules/gce_network"
  vpc_network = "test-vpc-1"
  vpc_subnet  = "us-east4-new"
}