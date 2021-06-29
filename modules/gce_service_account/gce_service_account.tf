resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = "vmCustomRole"
  title       = "VM Custom Role"
  description = "Role for giving metadata level access to service account"
  permissions = ["compute.instances.setMetadata"]
}
resource "google_project_iam_member" "project" {
  role    = google_project_iam_custom_role.custom_role.name
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
