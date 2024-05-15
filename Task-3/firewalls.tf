resource "google_compute_firewall" "euhq_firewall" {
  name    = "euhq-firewall"
  network = google_compute_network.euhq_vpc.name
  direction = "INGRESS"
  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["172.16.1.0/24", "172.20.1.0/24", "192.168.1.0/24"]
}

resource "google_compute_firewall" "americas_firewall" {
  name    = "americas-firewall"
  network = google_compute_network.america_vpc.name
  direction = "INGRESS"
  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0", "35.235.240.0/20"]
}

resource "google_compute_firewall" "asia_firewall" {
  name    = "asia-firewall"
  network = google_compute_network.asia_vpc.name
  direction = "INGRESS"
  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}