terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  project = "terraform-422619"
  region = "us-central1"
  credentials = "terraform-422619-26f996fca669.json"
}

resource "google_compute_network" "task2_vpc" {
  name                    = "task2-vpc"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "task2_subnet" {
  name          = "task2-subnet"
  ip_cidr_range = "10.220.0.0/24"
  network       = google_compute_network.task2_vpc.id
}

resource "google_compute_instance" "task2_vminstance" {
  name         = "task2-vminstance"
  machine_type = "n2-standard-2"
  zone = "us-central1-a"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "task2-vpc"
    subnetwork = "task2-subnet"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("startup-script.sh")

}

resource "google_compute_firewall" "task2_firewall" {
  name    = "task2-firewall"
  network = google_compute_network.task2_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_tags = ["webserver"]

  source_ranges = ["0.0.0.0/0"]
}

//output "vm_outputs" {
 // value = <<-EOT
 // http://${google_compute_instance.task2_vminstance.network_interface[0].access_config[0].nat_ip}
 // ${google_compute_instance.americas_server1.network_interface.0.network_ip}
  //EOT
//}