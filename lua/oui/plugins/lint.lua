-- Lintinig
local M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"williamboman/mason.nvim",
		},
	},
	config = function()
		local lint = require("lint")

		-- no need to lint c/cpp as clangd already embeds clang-tidy
		lint.linters_by_ft = {
			-- javascript = { "eslint" },
			-- typescript = { "eslint" },
			-- javascriptreact = { "eslint" },
			-- typescriptreact = { "eslint" },
			-- vue = { "eslint" },
			python = { "mypy", "ruff" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}

return {}
