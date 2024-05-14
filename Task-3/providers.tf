terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  project     = "terraform-422619"
  credentials = "terraform-422619-07e913c68309.json"
  region      = "europe-west1"
}