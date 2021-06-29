resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}
resource "google_project_iam_custom_role" "custom_role_1" {
  role_id     = var.custom_role_id
  title       = "${google_service_account.service_account.display_name} Custom Role"
  description = "Role for giving metadata level access to service account"
  permissions = ["compute.instances.setMetadata","compute.instances.get"]
}
resource "google_project_iam_member" "iam_role_1" {
  role    = google_project_iam_custom_role.custom_role_1.name
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
resource "google_project_iam_member" "iam_role_2" {
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
