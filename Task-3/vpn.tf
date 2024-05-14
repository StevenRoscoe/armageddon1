resource "google_compute_vpn_gateway" "eu_to_asia_vpn" {
  name    = "eu-to-asia-vpn"
  region = "europe-west1"
  network = google_compute_network.euhq_vpc.id
}

resource "google_compute_address" "eu_static_ip_vpn" {
  name = "eu-static-ip-vpn"
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "fr_esp_eu" {
  name        = "fr-esp-eu"
  region = "europe-west1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.eu_static_ip_vpn.address
  target      = google_compute_vpn_gateway.eu_to_asia_vpn.id
}

resource "google_compute_forwarding_rule" "fr_udp_eu_500" {
  name        = "fr-udp-eu-500"
  region = "europe-west1"
  ip_protocol = "UDP"
  port_range = "500"
  ip_address  = google_compute_address.eu_static_ip_vpn.address
  target      = google_compute_vpn_gateway.eu_to_asia_vpn.id
}

resource "google_compute_forwarding_rule" "fr_udp_eu_4500" {
  name        = "fr-udp-eu-4500"
  region = "europe-west1"
  ip_protocol = "UDP"
  port_range = "4500"
  ip_address  = google_compute_address.eu_static_ip_vpn.address
  target      = google_compute_vpn_gateway.eu_to_asia_vpn.id
}

resource "google_compute_vpn_tunnel" "eu_to_asia_tunnel" {
  name          = "eu-to-asia-tunnel"
  peer_ip       = google_compute_address.asia_static_ip_vpn.address
  shared_secret = sensitive("secretsecret")

  target_vpn_gateway = google_compute_vpn_gateway.eu_to_asia_vpn.id

  local_traffic_selector = ["10.187.45.0/24"]

  depends_on = [
    google_compute_forwarding_rule.fr_esp_eu,
    google_compute_forwarding_rule.fr_udp_eu_500,
    google_compute_forwarding_rule.fr_udp_eu_4500,
  ]
}

resource "google_compute_route" "eu_to_asia_vpn_route" {
  name       = "eu-to-asia-vpn-route"
  network    = google_compute_network.euhq_vpc.name
  dest_range = "192.168.56.0/24"
  priority   = 1000

  depends_on = [google_compute_vpn_tunnel.eu_to_asia_tunnel]

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.eu_to_asia_tunnel.id
}





resource "google_compute_vpn_gateway" "asia_to_eu_vpn" {
  name    = "asia-to-eu-vpn"
  region = "asia-south1"
  network = google_compute_network.asia_vpc.id
}

resource "google_compute_address" "asia_static_ip_vpn" {
  name = "asia-static-ip-vpn"
  region = "asia-south1"
}

resource "google_compute_forwarding_rule" "fr_esp_asia" {
  name        = "fr-esp-asia"
  ip_protocol = "ESP"
  region = "asia-south1"
  ip_address  = google_compute_address.asia_static_ip_vpn.address
  target      = google_compute_vpn_gateway.asia_to_eu_vpn.id
}

resource "google_compute_forwarding_rule" "fr_udp_asia_500" {
  name        = "fr-udp-asia-500"
  ip_protocol = "UDP"
  region = "asia-south1"
  port_range = "500"
  ip_address  = google_compute_address.asia_static_ip_vpn.address
  target      = google_compute_vpn_gateway.asia_to_eu_vpn.id
}

resource "google_compute_forwarding_rule" "fr_udp_asia_4500" {
  name        = "fr-udp-asia-4500"
  ip_protocol = "UDP"
  region = "asia-south1"
  port_range = "4500"
  ip_address  = google_compute_address.asia_static_ip_vpn.address
  target      = google_compute_vpn_gateway.asia_to_eu_vpn.id
}

resource "google_compute_vpn_tunnel" "asia_to_eu_tunnel" {
  name          = "asia-to-eu-tunnel"
  peer_ip       = google_compute_address.eu_static_ip_vpn.address
  shared_secret = sensitive("secretsecret")

  target_vpn_gateway = google_compute_vpn_gateway.asia_to_eu_vpn.id

  local_traffic_selector = ["192.168.56.0/24"]

  depends_on = [
    google_compute_forwarding_rule.fr_esp_asia,
    google_compute_forwarding_rule.fr_udp_asia_500,
    google_compute_forwarding_rule.fr_udp_asia_4500,
  ]
}

resource "google_compute_route" "asia_to_eu_vpn_route" {
  name       = "asia-to-eu-vpn-route"
  network    = google_compute_network.asia_vpc.name
  dest_range = "10.187.45.0/24"
  priority   = 1000

  depends_on = [google_compute_vpn_tunnel.asia_to_eu_tunnel]

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.asia_to_eu_tunnel.id
}