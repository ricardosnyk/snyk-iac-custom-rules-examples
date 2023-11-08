package rules.VPC_FLOW_LOG_EXCEPTION

import data.snyk

input_type := "tf"

resource_type := "MULTIPLE"

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
flow_logs := snyk.resources("aws_flow_log")

has_flow_log := { vpc_id |
	vpc_id := flow_logs[_].vpc_id
}

acceptable_vpcs(vpc) {
	vpc.tags.name == "cloudbank-fix"
}

acceptable_vpcs(vpc) {
	has_flow_log[vpc.id]
}

deny[info] {
	vpc := vpcs[_]
	not acceptable_vpcs(vpc)
	info := {"resource": vpc}
}

resources[info] {
	vpc := vpcs[_]
	info := {"resource":vpc}
}

