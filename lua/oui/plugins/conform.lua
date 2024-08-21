-- Formatting
local M = {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
			},
		},

		config = function()
			require("conform").setup({
				formatters_by_ft = {

					c = { "clang_format" },
					cpp = { "clang_format" },
					cmake = { "cmake_format" },
					lua = { "stylua" },
					python = { "isort", "black" }, -- isort for imports, black for syntax.
					php = { "pint" },
					go = { "goimports", "gofumpt" },
					nix = { "nixfmt" },
					sh = { "shfmt" },

					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					yml = { "prettierd" },
					markdown = { "prettierd" },
					tex = { "latexindent" },
					css = { "prettierd" },
					-- javascript = { "prettierd" },
					-- javascriptreact = { "prettierd" },
					-- typescript = { "prettierd" },
					-- typescriptreact = { "prettierd" },
				},

				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})
		end,
	},
}

return M
