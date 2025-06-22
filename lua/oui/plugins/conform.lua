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
				formatters = {
					sqlfluff = {
						-- prepend_args = { "-d", "postgres" },
						args = { "format", "--dialect=postgres", "-" },
					},
				},
				formatters_by_ft = {

					c = { "clang_format" },
					cpp = { "clang_format" },
					cmake = { "cmake_format" },
					lua = { "stylua" },
					python = { "ruff_organize_imports", "ruff" },
					php = { "pint" },
					go = { "goimports", "gofumpt" },
					nix = { "nixfmt" },
					sh = { "shfmt" },
          scala = { "scalafmt" },

					html = { "prettierd" },
					json = { "prettierd" },
					yaml = { "prettierd" },
					yml = { "prettierd" },
					markdown = { "prettierd" },
					tex = { "latexindent" },
					css = { "prettierd" },
					sql = { "sqlfmt" },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
				},

				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 1500, lsp_format = "fallback" }
				end,
			})
		end,
	},
}

if M ~= nil then
	-- User command to toggle format on save:
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

	-- User command to format a range:
	vim.api.nvim_create_user_command("Format", function(args)
		local range = nil
		if args.count ~= -1 then
			local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			range = {
				start = { args.line1, 0 },
				["end"] = { args.line2, end_line:len() },
			}
		end
		require("conform").format({ async = true, lsp_format = "fallback", range = range })
	end, { range = true })

	vim.keymap.set("n", "<M-f>", ":Format<cr>", { desc = "Format buffer" })
	vim.keymap.set("v", "<M-f>", ":Format<cr>", { desc = "Format range" })
	vim.b.disable_autoformat = true
	vim.g.disable_autoformat = true
end

return M
