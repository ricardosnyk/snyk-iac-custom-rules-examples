provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
}

resource "google_cloudfunctions_function" "valid" {
  name        = "function-test"
  description = "My function"
  runtime     = "nodejs16"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}

resource "google_cloudfunctions_function" "invalid" {
  name        = "function-test"
  description = "My function"
  runtime     = "nodejs8"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}

resource "google_cloudfunctions_function" "invalid2" {
  name        = "function-test"
  description = "My function"
  runtime     = "go111"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}

resource "google_cloudfunctions_function" "valid2" {
  name        = "function-test"
  description = "My function"
  runtime     = "python38"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "helloGET"
}