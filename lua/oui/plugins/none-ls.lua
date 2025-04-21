local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		async = false,
	})
end

local M = {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.isort,
				-- null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.cmake_format,
				null_ls.builtins.formatting.nixfmt,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.pint,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofumpt,

				null_ls.builtins.diagnostics.cmake_lint,
				null_ls.builtins.diagnostics.phpcs,
				-- null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.hadolint,
				null_ls.builtins.diagnostics.golangci_lint,
				-- null_ls.builtins.diagnostics.revive,

				-- null_ls.builtins.code_actions.refactoring, -- doesn't work
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.code_actions.impl,
			},

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- vim.lsp.buf.format({ async = false })
							lsp_formatting(bufnr)
						end,
					})
				end
			end,
		})
	end,
}
return {}
