package rules.AZURE_FUNCTIONS_RUNTIMES

import data.snyk

# This is a sample rule which strictly restricts the use of specific runtimes. The Azure Terraform
# provider only accepts specific values, so it will will error out if you select an unsupported runtime
# this example rule simply checks against a set of runtimes that are allowed. 

input_type := "tf"

resource_type := "MULTIPLE"

metadata := {
	"id": "AZURE_FUNCTIONS_RUNTIMES",
	"severity": "high",
	"title": "Allowed Azure Functions Runtimes",
	"description": "Make sure that you are using a runtime that we allow",
	"product": [
		"iac",
		"cloud",
	],
}

azure_function_types := {"azurerm_linux_function_app", "azurerm_windows_function_app"}

# Note: this is a list of actual application stacks. The notion of what is permitted vs. not permitted
# is solely used as an example for a possible custom rule for this scenario.

permitted_stacks := [ 
  { "node_version": "14" },
  { "powershell_core_version": "7" },
]


all_functions := [function |
	function_type := azure_function_types[_]
	functions := snyk.resources(function_type)
  function := functions[_]
]

approved_stack(function) {
	stack := function.site_config[_].application_stack[_]
	stack == permitted_stacks[_]
}

deny[info] {
	function := all_functions[_]
	not approved_stack(function)
	info := {"resource": function}
}

