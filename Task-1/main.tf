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
  region      = "us-central1"
  credentials = "terraform-422619-26f996fca669.json"
}

resource "google_storage_bucket" "sroscoe_public_bucket" {
  name     = "sroscoe-bucket"
  location = "US-CENTRAL1"

  website {
    main_page_suffix = "index.html"
  }

  uniform_bucket_level_access = false
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.sroscoe_public_bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_object" "picture" {
  name   = "Kylo.jpg"
  source = "Kylo.jpg"
  bucket = google_storage_bucket.sroscoe_public_bucket.name
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.sroscoe_public_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "webserver" {
  name   = "index.html"
  source = "${path.module}/index.html"
  bucket = google_storage_bucket.sroscoe_public_bucket.name
}

output "website_url" {
  value = "https://${google_storage_bucket.sroscoe_public_bucket.name}.storage.googleapis.com/index.html"
}
