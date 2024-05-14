resource "google_compute_network_peering" "america_to_euhq" {
  name         = "america-to-euhq-01"
  network      = google_compute_network.america_vpc.self_link
  peer_network = google_compute_network.euhq_vpc.self_link
}

resource "google_compute_network_peering" "euhq_to_america" {
  name         = "euhq-to-america-01"
  network      = google_compute_network.euhq_vpc.self_link
  peer_network = google_compute_network.america_vpc.self_link
}
