resource "google_project_service" "project" {
  project = "hm-terraform-test"
  service = "run.googleapis.com"
}
