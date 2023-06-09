package rules.S3_ACL

import data.snyk

input_type := "tf"

metadata := {
	"id": "S3_BUCKET_ACL",
	"severity": "critical",
	"title": "All ACLs should be private",
	"description": "Checking S3 Buckets for Private ACLs using the new terraform format.",
	"product": [
		"iac",
		"cloud",
	],
}

buckets := snyk.resources("aws_s3_bucket")

deny[info] {
	bucket := buckets[_]
	acls := snyk.relates(bucket, "aws_s3_bucket.aws_s3_bucket_acl")
	acl := acls[_]
	acl.acl != "private"
	info := {"primary_resource": bucket}

}

resources[info] {
	bucket := buckets[_]
	info := {"primary_resource": bucket}
}

resources[info] {
	bucket := buckets[_]
	acls := snyk.relates(bucket, "aws_s3_bucket.aws_s3_bucket_acl")
	info := {
		"primary_resource": bucket,
		"resource": acls[_],
	}
}
