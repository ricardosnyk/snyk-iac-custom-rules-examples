package relations

import data.snyk

relations[info] {
	info := snyk.relation_from_fields(
		"aws_s3_bucket.aws_s3_bucket_acl",
		{"aws_s3_bucket": ["id", "bucket"]},
		{"aws_s3_bucket_acl": ["bucket", "acl"]},
	)
}

relations[info] {
	info := snyk.relation_from_fields(
		"aws_vpc.aws_flow_log",
		{"aws_vpc": ["id", "tags"]},
		{"aws_flow_log": ["vpc_id"]},
	)
}
