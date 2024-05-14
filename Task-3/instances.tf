resource "google_compute_instance" "eu_west_instance" {
  name         = "eu-west-instance"
  machine_type = "n2-standard-2"
  zone         = "europe-west1-b"

  tags = ["euwest"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.euhq_vpc.name
    subnetwork = google_compute_subnetwork.eugaminghq_subnet.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}

resource "google_compute_instance" "america_instance_01" {
  name         = "america-instance-01"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["america1"]

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.america_vpc.name
    subnetwork = google_compute_subnetwork.america_subnet_01.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}

resource "google_compute_instance" "america_instance_02" {
  name         = "america-instance-02"
  machine_type = "n2-standard-2"
  zone         = "us-west1-b"

  tags = ["america2"]

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.america_vpc.name
    subnetwork = google_compute_subnetwork.america_subnet_02.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}

resource "google_compute_instance" "asia_pacific_instance" {
  name         = "asia-pacific-instance"
  machine_type = "n2-standard-2"
  zone         = "asia-south1-b"

  tags = ["asiapacific"]

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = google_compute_network.asia_vpc.name
    subnetwork = google_compute_subnetwork.asia_subnet.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = file("${path.module}/startup-script.sh")
}