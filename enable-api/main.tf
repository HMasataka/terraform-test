resource "google_project_service" "project" {
  project = "scarlet-303003"
  service = "run.googleapis.com"
}
