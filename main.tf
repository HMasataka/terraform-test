provider "google" {
  project     = "scarlet-terraform"
  region      = "us-central1"
  zone        = "us-central1-c"
}

resource "google_storage_bucket" "private-bucket" {
  name          = "terraform-instance"
  location      = "asia-northeast1"
  storage_class = "REGIONAL"

  labels = {
    app = "test-app"
    env = "test"
  }
}
