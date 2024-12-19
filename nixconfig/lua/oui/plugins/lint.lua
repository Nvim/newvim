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
			cmake = { "cmakelint" },
			php = { "phpcs" },
			dockerfile = { "hadolint" },
			go = { "golangcilint" },
			sql = { "sqlfluff" },
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- javascriptreact = { "eslint_d" },
			-- typescriptreact = { "eslint_d" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
				if vim.g.disable_autolint or vim.b[bufnr].disable_autolint then
					return
				end
				lint.try_lint()
			end,
		})

		vim.api.nvim_create_user_command("LintEnable", function(args)
			if args.bang then
				vim.b.disable_autolint = true
			else
				vim.g.disable_autolint = true
			end
		end, { desc = "Enable auto-linting", bang = true })

		vim.api.nvim_create_user_command("LintDisable", function(args)
			if args.bang then
				vim.b.disable_autolint = false
			else
				vim.g.disable_autolint = false
			end
		end, { desc = "Disable auto-linting", bang = true })

		vim.api.nvim_create_user_command("Lint", function()
			lint.try_lint()
		end, { desc = "Lint buffer" })

    -- Disable Linting by default
    vim.g.disable_autolint = true

    vim.keymap.set("n", "<M-P>", ":Lint<cr>", {desc = "Lint buffer"})
	end,
}

return M
