local M = {

	settings = {
		gopls = {
			gofumpt = false, -- conform for goimports
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = false,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = false,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
			},
			usePlaceholders = false,
			completeUnimported = true,
      -- unset: enable a subset of staticcheck analyzers selected by gopls maintainers for runtime efficiency and analytic precision
      -- staticcheck = true 
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			semanticTokens = true,
      diagnosticsTrigger = "Save",
		},
	},
}

return M
