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

local set_lspsaga_mappings = function(bufnr)
	local opts = { buffer = bufnr, remap = false, silent = true }
	local set = vim.keymap.set
	set_lsp_telescope_mappings(bufnr)
	-- local lspsaga = require("lspsaga")

	set(
		"n",
		"<A-d>",
		"<cmd>Lspsaga term_toggle<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "Terminal" }
	)
	set(
		"n",
		"<leader>ld",
		"<cmd>Lspsaga peek_definition<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP definition" }
	)
	set("n", "<leader>lD", function()
		vim.lsp.buf.declaration()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP declaration" })
	set("n", "<leader>lh", function()
		vim.cmd("Lspsaga hover_doc")
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP hover info" })
	set("n", "<leader>lf", function()
		vim.diagnostic.open_float()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostic" })
	set("n", "<leader>lj", function()
		vim.cmd("Lspsaga diagnostic_jump_next")
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP next diagnostic" })
	set("n", "<leader>lk", function()
		vim.cmd("Lspsaga diagnostic_jump_prev")
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP prev diagnostic" })
	set("n", "<leader>la", function()
		vim.cmd("Lspsaga code_action")
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP code action" })
	set("n", "<leader>lR", function()
		vim.cmd("Lspsaga rename")
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
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp", "nvimdev/lspsaga.nvim" },
		},
		config = function()
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

			local vtsls = require("vtsls")
			local lspsaga = require("lspsaga")
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			local on_attach = function(_, bufnr)
				set_lspsaga_mappings(bufnr)
			end

			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = { Lua = {} },
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").cssls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").nixd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").emmet_language_server.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").ruff_lsp.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			require("lspconfig").intelephense.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			require("lspconfig").gopls.setup({
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- clangd: special settings:
			require("lspconfig").clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--fallback-style=llvm",
					"--offset-encoding=utf-16",
				},
				root_dir = vim.fs.root(
					vim.fs.joinpath(vim.env.PWD, "compile_commands.json"),
					{ ".clangd", ".clang-format", ".clang-tidy" }
				) or vim.fn.getcwd(),
				on_attach = function(_, bufnr)
					set_lspsaga_mappings(bufnr)
					vim.keymap.set("n", "<leader>ls", function()
						vim.cmd("ClangdSwitchSourceHeader")
					end, { buffer = bufnr, remap = false, silent = true, desc = "ClangdSwitchSourceHeader" })
				end,
			})

			require("lspconfig").cmake.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.volar.setup({
				enabled = true,
			})

			lspconfig.vtsls.setup({
				on_attach = function(_, bufnr)
					set_lspsaga_mappings(bufnr)
					-- vim.keymap.del("n", "<leader>ld", { buffer = bufnr })
					vim.keymap.set(
						"n",
						"<leader>lF", -- TODO: override leader+ld
						"<cmd>VtsExec goto_source_definition<cr>",
						{ desc = "Go to Typescript source definition" }
					)
					vim.keymap.set(
						"n",
						"<leader>lw",
						"<cmd>VtsExec file_references<cr>",
						{ desc = "Typescript file references" }
					)
					vim.keymap.set(
						"n",
						"<leader>lI",
						"<cmd>VtsExec organize_imports<cr>",
						{ desc = "Typescript Organize imports" }
					)
					vim.keymap.set(
						"n",
						"<leader>lM",
						"<cmd>VtsExec add_missing_imports<cr>",
						{ desc = "Typescript import missing" }
					)
					vim.keymap.set(
						"n",
						"<leader>lU",
						"<cmd>VtsExec remove_unused_imports<cr>",
						{ desc = "Typescript remove unused imports" }
					)
					vim.keymap.set(
						"n",
						"<leader>lT",
						"<cmd>VtsExec select_ts_version<cr>",
						{ desc = "Typescript select TS version" }
					)
				end,
				capabilities = capabilities,
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },

				-- Config
				settings = {
					complete_function_calls = true,
					vtsls = {

						-- True = don't use the bundled typescript version, use VTSLS bundled version instead.
						-- Use command typescript.selectTypescriptVersion to switch
						autoUseWorkspaceTsdk = false,

						experimental = {
							completion = {
								-- Optimize sorting of entries server-side
								enableServerSideFuzzyMatch = true,
							},
						},

						typescript = {
							-- Inlay hints setup:
							inlayHints = {
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},

							-- Misc:
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
						},

						-- For Vue:
						tsserver = {
							globalPlugins = {
								{
									name = "@vue/typescript-plugin",
									location = "/home/naim/.npm-packages/lib/node_modules/@vue/language-server",
									languages = { "vue" },
									configNamespace = "typescript",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
				},
			})

			lspconfig.eslint.setup({
				settings = {
					workingDirectories = { mode = "auto" },
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			-- require("lspconfig").glsl_analyzer.setup({})
			require("ufo").setup()
		end,
	},
}

return M
