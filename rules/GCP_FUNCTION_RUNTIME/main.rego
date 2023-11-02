package rules.GCP_FUNCTION_RUNTIME

import data.gcp_deprecated_runtimes as lib

input_type := "tf"

resource_type := "google_cloudfunctions_function"

metadata := {
	"id": "GCP_FUNCTION_RUNTIME",
	"severity": "high",
	"title": "Confirm that non-deprecated runtimes are being used",
	"description": "Make sure that you are not using a deprecated runtime for your cloud functions",
	"product": [
		"iac",
		"cloud",
	],
}

deny[info] {
	lib.dep_runtimes[input.runtime]
	info := {"resource": input}
}
