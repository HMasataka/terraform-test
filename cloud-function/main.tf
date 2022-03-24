provider "google" {
  project = "scarlet-303003"
  region  = "us-central1"
  zone    = "us-central1-c"
}

data "archive_file" "function_archive" {
  type        = "zip"
  source_dir  = "sample-function"
  output_path = "source.zip"
}

resource "google_storage_bucket" "bucket" {
  name          = "terraform-instance"
  location      = "asia-northeast1"
  storage_class = "REGIONAL"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./source.zip"
}

resource "google_cloudfunctions_function" "function" {
  name        = "function-test"
  description = "My function"
  runtime     = "go113"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "HelloHTTP"
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
