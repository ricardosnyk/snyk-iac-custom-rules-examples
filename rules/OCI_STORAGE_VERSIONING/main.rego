package rules.OCI_STORAGE_VERSIONING

input_type := "tf"

resource_type := "oci_objectstorage_bucket"

metadata := {
	"id": "OCI_STORAGE_VERSIONING",
	"severity": "high",
	"title": "Enable Versioning",
	"description": "Make sure that versioning is enabled on all object storage buckets",
	"product": ["iac"],
}

deny[info] {
	input.versioning != "Enabled"
	info := {"resource": input}
}
