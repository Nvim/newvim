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
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP peek definition" }
	)

	set(
		"n",
		"<leader>lD",
		"<cmd>Lspsaga peek_type_definition<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP peek declaration" }
	)

	set(
		"n",
		"<leader>lh",
		"<cmd>Lspsaga hover_doc<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP hover info" }
	)

	set(
		"n",
		"<leader>lj",
		"<cmd>Lspsaga diagnostic_jump_next<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP next diagnostic" }
	)

	set(
		"n",
		"<leader>lk",
		"<cmd>Lspsaga diagnostic_jump_prev<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP prev diagnostic" }
	)

	set(
		"n",
		"<leader>la",
		"<cmd>Lspsaga code_action<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP code action" }
	)

	set(
		"n",
		"<leader>lR",
		"<cmd>Lspsaga rename<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSP rename" }
	)

	set(
		"n",
		"<leader>lx",
		"<cmd>Lspsaga finder def+imp+ref<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga finder (float)" }
	)

	set(
		"n",
		"<leader>lX",
		"<cmd>Lspsaga finder def+imp+ref<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga finder (bottom)" }
	)

	set(
		"n",
		"<leader>lc",
		"<cmd>Lspsaga incoming_calls ++float<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga finder (float)" }
	)

	set(
		"n",
		"<leader>lC",
		"<cmd>Lspsaga incoming_calls ++normal<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga finder (bottom)" }
	)

	set(
		"n",
		"<leader>lo",
		"<cmd>Lspsaga outgoing_calls ++float<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga outgoing calls (float)" }
	)

	set(
		"n",
		"<leader>lO",
		"<cmd>Lspsaga outgoing_calls ++normal<cr>",
		{ buffer = bufnr, remap = false, silent = true, desc = "LSPSaga outgoing calls (bottom)" }
	)

	set("n", "<leader>lS", function()
		vim.lsp.buf.signature_help()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP signature help" })

	set("n", "<leader>lf", function()
		vim.diagnostic.open_float()
	end, { buffer = bufnr, remap = false, silent = true, desc = "LSP diagnostic" })
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
			{ "saghen/blink.cmp", "nvimdev/lspsaga.nvim" },
		},
		opts = {
			inlayHints = {
				enabled = true,
				exclude = {},
			},
			codelenses = {
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

			-- Callback to run for all server on attach:
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					-- Merge blink capabilites:
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if has_blink then
						client.capabilities = blink.get_lsp_capabilities(client.capabilites)
					end

					-- Set keymaps:
					if has_lspsaga then
						set_lspsaga_mappings(ev.buf)
					else
						set_lsp_mappings(ev.buf)
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

			-- -- clangd: special settings:
			-- require("lspconfig").clangd.setup({
			-- 	cmd = {
			-- 		"clangd",
			-- 		"--background-index",
			-- 		"--clang-tidy",
			-- 		"--header-insertion=iwyu",
			-- 		"--completion-style=detailed",
			-- 		"--function-arg-placeholders",
			-- 		"--fallback-style=llvm",
			-- 		"--offset-encoding=utf-16",
			-- 	},
			-- 	root_dir = vim.fs.root(
			-- 		vim.fs.joinpath(vim.env.PWD, "compile_commands.json"),
			-- 		{ ".clangd", ".clang-format", ".clang-tidy" }
			-- 	) or vim.fn.getcwd(),
			-- 	on_attach = function(_, bufnr)
			-- 		set_lspsaga_mappings(bufnr)
			-- 		vim.keymap.set("n", "<leader>ls", function()
			-- 			vim.cmd("ClangdSwitchSourceHeader")
			-- 		end, { buffer = bufnr, remap = false, silent = true, desc = "ClangdSwitchSourceHeader" })
			-- 	end,
			-- })
			--
			-- lspconfig.volar.setup({
			-- 	enabled = true,
			-- })
			--
			-- lspconfig.vtsls.setup({
			-- 	on_attach = function(_, bufnr)
			-- 		set_lspsaga_mappings(bufnr)
			-- 		-- vim.keymap.del("n", "<leader>ld", { buffer = bufnr })
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lF", -- TODO: override leader+ld
			-- 			"<cmd>VtsExec goto_source_definition<cr>",
			-- 			{ desc = "Go to Typescript source definition" }
			-- 		)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lw",
			-- 			"<cmd>VtsExec file_references<cr>",
			-- 			{ desc = "Typescript file references" }
			-- 		)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lI",
			-- 			"<cmd>VtsExec organize_imports<cr>",
			-- 			{ desc = "Typescript Organize imports" }
			-- 		)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lM",
			-- 			"<cmd>VtsExec add_missing_imports<cr>",
			-- 			{ desc = "Typescript import missing" }
			-- 		)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lU",
			-- 			"<cmd>VtsExec remove_unused_imports<cr>",
			-- 			{ desc = "Typescript remove unused imports" }
			-- 		)
			-- 		vim.keymap.set(
			-- 			"n",
			-- 			"<leader>lT",
			-- 			"<cmd>VtsExec select_ts_version<cr>",
			-- 			{ desc = "Typescript select TS version" }
			-- 		)
			-- 	end,
			-- 	capabilities = capabilities,
			-- 	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			--
			-- 	-- Config
			-- 	settings = {
			-- 		complete_function_calls = true,
			-- 		vtsls = {
			--
			-- 			-- True = don't use the bundled typescript version, use VTSLS bundled version instead.
			-- 			-- Use command typescript.selectTypescriptVersion to switch
			-- 			autoUseWorkspaceTsdk = false,
			--
			-- 			experimental = {
			-- 				completion = {
			-- 					-- Optimize sorting of entries server-side
			-- 					enableServerSideFuzzyMatch = true,
			-- 				},
			-- 			},
			--
			-- 			typescript = {
			-- 				-- Inlay hints setup:
			-- 				inlayHints = {
			-- 					parameterNames = { enabled = "literals" },
			-- 					parameterTypes = { enabled = true },
			-- 					variableTypes = { enabled = true },
			-- 					propertyDeclarationTypes = { enabled = true },
			-- 					functionLikeReturnTypes = { enabled = true },
			-- 					enumMemberValues = { enabled = true },
			-- 				},
			--
			-- 				-- Misc:
			-- 				updateImportsOnFileMove = { enabled = "always" },
			-- 				suggest = {
			-- 					completeFunctionCalls = true,
			-- 				},
			-- 			},
			--
			-- 			-- For Vue:
			-- 			tsserver = {
			-- 				globalPlugins = {
			-- 					{
			-- 						name = "@vue/typescript-plugin",
			-- 						-- TODO: :h lspconfig-setup-hook
			-- 						-- location = "/home/naim/.npm-packages/lib/node_modules/@vue/language-server",
			-- 						location = get_pkg_path(
			-- 							"vue-language-server",
			-- 							"/node_modules/@vue/language-server"
			-- 						),
			-- 						languages = { "vue" },
			-- 						configNamespace = "typescript",
			-- 						enableForWorkspaceTypeScriptVersions = true,
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })
			--
			-- lspconfig.eslint.setup({
			-- 	settings = {
			-- 		workingDirectories = { mode = "auto" },
			-- 	},
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	filetypes = { "javscript", "typescript", "javascriptreact", "typescriptreact", "vue" }, -- disable vue
			-- })

			-- require("lspconfig").glsl_analyzer.setup({})
			-- require("ufo").setup()
		end,
	},
}

return M
