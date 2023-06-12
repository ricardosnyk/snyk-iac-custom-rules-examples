package rules.REQUIRED_S3_BUCKET_TAGS

import data.snyk

input_type := "tf"

metadata := {
	"id": "REQUIRED_S3_BUCKET_TAGS",
	"severity": "high",
	"title": "S3 Bucket Tags",
	"description": "All S3 Buckets must be tagged properly - they need to have an owner tag, and a classification tag with the proper values.",
	"product": [
		"iac",
		"cloud",
	],
}

buckets := snyk.resources("aws_s3_bucket")

owners := {
	"devteam1",
	"devteam2",
	"devteam3",
	"devteam4"
}

classifications := {
	"public",
	"internal",
	"confidential"
}


properly_tagged(bucket) {
	owners[bucket.tags.owner]
	classifications[bucket.tags.classification]
}

deny[info] {
	bucket := buckets[_]
	not properly_tagged(bucket)
	info := {"resource": bucket}
}

resources[info] {
	bucket := buckets[_]
	info := {"resource": bucket}
}
