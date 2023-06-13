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

acceptable_vpcs(vpc) {
	vpc.tags.name == "cloudbank-fix"
}

acceptable_vpcs(vpc) {
	logs := snyk.relates(vpc, "aws_vpc.aws_flow_log")[_]
	count(logs) < 0
}

deny[info] {
	vpc := vpcs[_]
	not acceptable_vpcs(vpc)

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
