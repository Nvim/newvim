local M = {
	{
		"yioneko/nvim-vtsls",
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		cond = function()
			return vim.bo.filetype ~= "java"
		end,
		dependencies = {
			{
				"saghen/blink.cmp",
				-- "nvimdev/lspsaga.nvim",
			},
		},
		opts = {
			inlay_hints = {
				enabled = false,
				exclude = { "cpp", "go" },
			},
			codelens = {
				enabled = false,
			},
			capabilities = {
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
				basedpyright = {},
				intelephense = {},
				metals = {},
			},
		},
		config = function(_, opts)
			-- some ricing before setting up LSP:
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

			-- local vtsls = require("vtsls")
			local has_blink, blink = pcall(require, "blink.cmp")
			-- local has_lspsaga, lspsaga = pcall(require, "lspsaga")

			-- Callback to run for all server on attach:
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- Merge blink capabilites:
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if has_blink then
						client.capabilities = blink.get_lsp_capabilities(opts.capabilites)
					end
					require("ufo").setup()

					-- Set keymaps:
					-- if has_lspsaga == false then
					-- 	set_lsp_mappings(ev.buf)
					-- end
					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1 })
					end)
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1 })
					end)
					vim.keymap.set("n", "lf", function()
						vim.diagnostic.open_float()
					end)

					-- Conditionally enable codeLens:
					if opts.codelens.enabled and vim.lsp.codelens then
						if client ~= nil and client.supports_method(client, "textDocument/codeLens") then
							vim.lsp.codelens.refresh()
							vim.keymap.set("n", "<leader>lL", function()
								vim.lsp.codelens.run()
							end, { buffer = ev.buf, remap = false, silent = true, desc = "LSP Codelens" })
							vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
								buffer = ev.buf,
								callback = vim.lsp.codelens.refresh,
							})
						end
					end

					-- Same for inlay hints:
					if opts.inlay_hints.enabled then
						if client ~= nil and client.supports_method(client, "textDocument/inlayHint") then
							if
								vim.api.nvim_buf_is_valid(ev.buf)
								and vim.bo[ev.buf].buftype == ""
								and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[ev.buf].filetype)
							then
								vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
								vim.keymap.set("n", "<leader>lH", function()
									vim.lsp.inlay_hint.enable(
										not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
										{ bufnr = ev.buf }
									)
								end, {
									buffer = ev.buf,
									remap = false,
									silent = true,
									desc = "LSP toggle inlay hints",
								})
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
