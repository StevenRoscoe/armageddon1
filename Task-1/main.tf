terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  project     = "terraform-mania-1997"
  region      = "us-central1"
  zone        = "us-central-a"
  credentials = "terraform-mania-1997-96587c92223a.json"
}

resource "google_storage_bucket" "sroscoe_public_bucket" {
  name          = "sroscoe-terraform-bucket-task1"
  location      = "US-CENTRAL1"
  force_destroy = true

  public_access_prevention = "inherited"
}

#resource "google_storage_bucket_access_control" "public_rule" {
  #bucket = google_storage_bucket.sroscoe_terraform_bucket_task1
  #role   = "READER"
  #entity = "allUsers"
#}