resource "google_compute_network" "euhq_vpc" {
  name                    = "euhq-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "eugaminghq_subnet" {
  name          = "eugaminghq-subnet"
  ip_cidr_range = "10.160.0.0/24"
  region        = "europe-west1"
  network       = google_compute_network.euhq_vpc.id
}

resource "google_compute_network" "america_vpc" {
  name                    = "america-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "america_subnet_01" {
  name          = "america-subnet-1"
  ip_cidr_range = "172.16.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.america_vpc.id
}

resource "google_compute_subnetwork" "america_subnet_02" {
  name          = "america-subnet-2"
  ip_cidr_range = "172.20.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.america_vpc.id
}

resource "google_compute_network" "asia_vpc" {
  name                    = "asia-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "asia_subnet" {
  name          = "asiapacific-subnet"
  ip_cidr_range = "192.168.1.0/24"
  region        = "asia-south1"
  network       = google_compute_network.asia_vpc.id
}