-- LSP Server List:
local ensure_installed = {
	lsps = {
		"bashls",
		"clangd",
		"jdtls",
		"intelephense",
		"html",
		"cssls",
		"volar",
		"emmet_language_server",
		"tsserver",
		"vtsls",
		"tailwindcss",
		-- "eslint",
		"lua_ls",
		"pyright",
		"glsl_analyzer",
		"nil_ls",
		"texlab",
		"ltex",
		"marksman",
	},

	others = {
		-- lint
		"eslint_d", -- linter
		"mypy", --linter(static type check)
		"ruff", --fast linting

		-- format
		"prettier", -- formatter
		"blade-formatter", --formatter
		"pint", --formatter
		"stylua", -- formatter
		"isort", --formatter
		"black", --formatter
		"latexindent", --formatter
		"nixpkgs-fmt",
	},
}

return ensure_installed
