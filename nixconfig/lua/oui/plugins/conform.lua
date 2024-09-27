-- Formatting
local M = {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre" },
		cmd = { "ConformInfo" },
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

				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 500, lsp_format = "fallback" }
				end,
			})
		end,
	},
}

if M ~= nil then
	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			-- FormatDisable! will disable formatting just for this buffer
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
	end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	})
	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end, {
		desc = "Re-enable autoformat-on-save",
	})
end

return M
-- Old format on save:
-- format_on_save = {
-- 	lsp_fallback = true,
-- 	async = false,
-- 	timeout_ms = 500,
-- },
