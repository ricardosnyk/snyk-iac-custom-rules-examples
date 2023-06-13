package rules.VPC_FLOW_LOG_EXCEPTION

import data.snyk

input_type := "tf"

metadata := {
	"id": "VPC_FLOW_LOG_EXCEPTION",
	"severity": "high",
	"title": "VPC Flow Log Exception based on tag",
	"description": "All VPCs must have flow logs unless they have a specific key value pair - this rule modifies SNYK-CC-00151 to exclude a vpc based on its tags",
	"product": [
		"iac",
		"cloud",
	],
}

vpcs := snyk.resources("aws_vpc")

acceptable_vpc_tags(vpc) {
	vpc.tags.name == "cloudbank-fix"
}

deny[info] {
	vpc := vpcs[_]
	logs := snyk.relates(vpc, "aws_vpc.aws_flow_log")[_]
	not acceptable_vpc_tags(vpc)
	vpc.id != logs.vpc_id

	info := {"primary_resource": vpc}
}

resources[info] {
	vpc := vpcs[_]
	info := {"primary_resource": vpc}
}

resources[info] {
	vpc := vpcs[_]
	logs := snyk.relates(vpc, "aws_vpc.aws_flow_log")
	info := {
		"primary_resource": vpc,
		"resource": logs[_],
	}
}
