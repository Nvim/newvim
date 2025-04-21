local set_lsp_telescope_mappings = function(bufnr)
	local opts = { buffer = bufnr, remap = false, silent = true }
	local set = vim.keymap.set
	set(
		"n",
		"<leader>lr",
		"<cmd>Telescope lsp_references<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP references" }
	)
	set(
		"n",
		"<leader>lS",
		"<cmd>Telescope lsp_workspace_symbols<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP symbols" }
	)
	set(
		"n",
		"<leader>li",
		"<cmd>Telescope lsp_implementations<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP implementation" }
	)
	set(
		"n",
		"<leader>le",
		"<cmd>Telescope diagnostics<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostics" }
	)
end

local set_lsp_mappings = function(bufnr)
	local set = vim.keymap.set

	set_lsp_telescope_mappings(bufnr)

	-- set("n", "<leader>ld", function()
	-- 	vim.lsp.buf.definition()
	-- end, { buffer = bufnr, remap = false, silent = true, desc = "LSP definition" })
	set("n", "<leader>lD", function()
		vim.lsp.buf.declaration()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP declaration" })
	set("n", "<leader>lh", function()
		vim.lsp.buf.hover()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP hover info" })
	set("n", "<leader>lf", function()
		vim.diagnostic.open_float()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostic" })
	set("n", "<leader>lj", function()
		vim.diagnostic.goto_next()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP next diagnostic" })
	set("n", "<leader>lk", function()
		vim.diagnostic.goto_prev()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP prev diagnostic" })
	set("n", "<leader>la", function()
		vim.lsp.buf.code_action()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP code action" })
	set("n", "<leader>lR", function()
		vim.lsp.buf.rename()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP rename" })
	set("n", "<leader>lS", function()
		vim.lsp.buf.signature_help()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP signature help" })
end

local M = {
	{
		"yioneko/nvim-vtsls",
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
    cond = function ()
      return vim.bo.filetype ~= "java"
    end,
		dependencies = {
			{ "saghen/blink.cmp", "nvimdev/lspsaga.nvim" },
		},
		opts = {
			inlay_hints = {
				enabled = false,
				exclude = { "clangd" },
			},
			codelens = {
				enabled = false,
			},
			capabilites = {
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
			},

			-- Servers:
			servers = {
				lua_ls = require("oui.plugins.lsp.server_opts.lua_ls"),
				gopls = require("oui.plugins.lsp.server_opts.gopls"),
				clangd = require("oui.plugins.lsp.server_opts.clangd"),
				vtsls = require("oui.plugins.lsp.server_opts.vtsls"),
				volar = { enabled = true },
				eslint = {
					settings = {
						workingDirectories = { mode = "auto" },
					},
					filetypes = { "javscript", "typescript", "javascriptreact", "typescriptreact", "vue" }, -- disable vue
				},
				html = {},
				cssls = {},
				bashls = {},
				nixd = {},
				emmet_language_server = {},
				tailwindcss = {},
				ruff = {},
				pyright = {},
				intelephense = {},
			},
		},
		config = function(_, opts)
			-- some ricing before setting up LSP:
			vim.diagnostic.config({
				virtual_text = false,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = {
					source = "if_many",
				},
			})

			-- local vtsls = require("vtsls")
			local has_blink, blink = pcall(require, "blink.cmp")
			local has_lspsaga, lspsaga = pcall(require, "lspsaga")
			require("ufo").setup()

			-- Callback to run for all server on attach:
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- Merge blink capabilites:
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if has_blink then
						client.capabilities = blink.get_lsp_capabilities(client.capabilites)
					end

					-- Set keymaps:
					if has_lspsaga == false then
						set_lsp_mappings(ev.buf)
					end

					-- Conditionally enable codeLens:
					if opts.codelens.enabled and vim.lsp.codelens then
						if client.supports_method(client, "textDocument/codeLens") then
							vim.lsp.codelens.refresh()
							vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
								buffer = ev.buf,
								callback = vim.lsp.codelens.refresh(),
							})
						end
					end

					-- Same for inlay hints:
					if opts.inlay_hints.enabled then
						if client.supports_method(client, "textDocument/inlayHint") then
							if
								vim.api.nvim_buf_is_valid(ev.buf)
								and vim.bo[ev.buf].buftype == ""
								and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[ev.buf].filetype)
							then
								vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
							end
						end
					end
				end,
			})

			local servers = opts.servers

			local function setup(server)
				local server_opts = servers[server] or {}
				if server_opts.enabled == false then
					return
				end
				require("lspconfig")[server].setup(server_opts)
			end

			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					setup(server)
				end
			end
		end,
	},
}

return M
