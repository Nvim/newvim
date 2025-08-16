-- some comment :/
require("oui.core.keymaps")
require("oui.core.options")
require("oui.core.autocommands")

vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.diagnostic.config({
	virtual_text = {
		current_line = true,
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
})

local capabilities = {
	workspace = {
		fileOperations = {
			didRename = true,
			willRename = true,
		},
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
}

-- Enable some LSPs:
vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")
-- vim.lsp.enable('eslint')
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("bashls")
vim.lsp.enable("nixd")
vim.lsp.enable("emmet_language_server")
-- vim.lsp.enable("tailwindcss")
vim.lsp.enable("ruff")
vim.lsp.enable("basedpyright")
vim.lsp.enable("intelephense")
vim.lsp.enable("metals")

-- Callback to run for all server on attach:
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local has_blink, blink = pcall(require, "blink.cmp")
		-- Merge blink capabilites:
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if has_blink then
			client.capabilities = blink.get_lsp_capabilities(capabilities)
		end
		require("ufo").setup()

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
		end)
		vim.keymap.set("n", "<leader>lf", function()
			vim.diagnostic.open_float()
		end)

    -- vim.keymap.del('n', 'K', { buffer = ev.buf })
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
        border = "rounded",
        max_height = 40,
        max_width = 120,
      })
		end, { buffer = true })

		-- Conditionally enable codeLens:
		-- if opts.codelens.enabled and vim.lsp.codelens then
		-- 	if client ~= nil and client.supports_method(client, "textDocument/codeLens") then
		-- 		vim.lsp.codelens.refresh()
		-- 		vim.keymap.set("n", "<leader>lL", function()
		-- 			vim.lsp.codelens.run()
		-- 		end, { buffer = ev.buf, remap = false, silent = true, desc = "LSP Codelens" })
		-- 		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
		-- 			buffer = ev.buf,
		-- 			callback = vim.lsp.codelens.refresh,
		-- 		})
		-- 	end
		-- end

		-- Same for inlay hints:
		-- if opts.inlay_hints.enabled then
		-- 	if client ~= nil and client.supports_method(client, "textDocument/inlayHint") then
		-- 		if
		-- 			vim.api.nvim_buf_is_valid(ev.buf)
		-- 			and vim.bo[ev.buf].buftype == ""
		-- 			and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[ev.buf].filetype)
		-- 		then
		-- 			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		-- 			vim.keymap.set("n", "<leader>lH", function()
		-- 				vim.lsp.inlay_hint.enable(
		-- 					not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
		-- 					{ bufnr = ev.buf }
		-- 				)
		-- 			end, {
		-- 				buffer = ev.buf,
		-- 				remap = false,
		-- 				silent = true,
		-- 				desc = "LSP toggle inlay hints",
		-- 			})
		-- 		end
		-- 	end
		-- end
	end,
})
