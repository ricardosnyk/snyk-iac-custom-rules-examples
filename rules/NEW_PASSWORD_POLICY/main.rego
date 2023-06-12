package rules.NEW_PASSWORD_POLICY

import data.snyk

input_type := "cloud_scan"

metadata := {
	"id": "NEW_PASSWORD_POLICY",
	"severity": "high",
	"title": "Increase the number of characters in our password policy",
	"description": "All of our password policies now require a minimum of 17 characters instead of the CIS recommendation of 14 characters",
	"product": ["cloud"],
}

password_pol := snyk.resources("aws_iam_account_password_policy")[_]

deny[info] {
	count(password_pol) < 1 
	info := {
		"message": "This account does not contain a password policy",
		"resource": password_pol
		}
}

deny[info] {
	password_pol.minimum_password_length < 17
	info := {"resource": password_pol}
}

resources[info] {
	info := {"resource": password_pol}
}