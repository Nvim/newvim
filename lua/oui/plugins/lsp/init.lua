-- TODO: jdtls (https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/setup-with-nvim-jdtls.md)

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

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
function get_pkg_path(pkg, path, opts)
	pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
	opts = opts or {}
	opts.warn = opts.warn == nil and true or opts.warn
	path = path or ""
	local ret = root .. "/packages/" .. pkg .. "/" .. path
	if opts.warn and not vim.loop.fs_stat(ret) and not require("lazy.core.config").headless() then
		print(
			("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(
				pkg,
				path
			)
		)
	end
	return ret
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
		"williamboman/mason.nvim",
		-- cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = {
			ensure_installed = server_list.others,
		},

		config = function(_, opts)
			require("mason").setup(opts)
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},

	-- Autocompletion: view cmp.lua
	-- LSP, servers are configured in the mason-lspconfig plugins' config, not directly lspconfig
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
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

			-- This is where all the LSP shenanigans will live
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				set_my_mappings(bufnr)
			end)

			lsp_zero.set_sign_icons({
				error = "✘",
				warn = "▲",
				hint = "⚑",
				info = "»",
			})

			-- require("lspconfig").glsl_analyzer.setup({})
			require("mason-lspconfig").setup({
				ensure_installed = server_list.lsps,
				handlers = {
					lsp_zero.default_setup,
					lsp_zero.set_server_config({
						capabilities = {
							textDocument = {
								foldingRange = {
									dynamicRegistration = false,
									lineFoldingOnly = true,
								},
							},
						},
					}),
					lsp_zero.setup_servers(
						{ server_list.lsps },
						{ exclude = { "lua_ls", "clangd", "tsserver", "ltex", "vtsls" } }
					),

					-- setup lua for neovim (lspzero provided)
					lua_ls = function()
						local lua_opts = lsp_zero.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
					ltex = function()
						require("lspconfig").ltex.setup({
							settings = {
								ltex = {
									language = "fr",
									enabled = true,
								},
							},
						})
					end,
					-- fix illuminate + null_ls conflict TODO: try without it
					clangd = function()
						require("lspconfig").clangd.setup({
							cmd = { "clangd", "--offset-encoding=utf-16" },
							on_attach = function(client, bufnr)
								local opts = { buffer = bufnr, remap = false }
								local set = vim.keymap.set
								set("n", "<leader>ls", function()
									vim.cmd("ClangdSwitchSourceHeader")
								end, opts, { desc = "Clangd Switch Source Header" })
								lsp_zero.on_attach(client, bufnr)
								require("clangd_extensions.inlay_hints").setup_autocmd()
								require("clangd_extensions.inlay_hints").set_inlay_hints()
							end,
						})
					end,
					tsserver = lsp_zero.noop,

					vtsls = function()
						require("lspconfig").vtsls.setup({
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
								"vue",
							},
							settings = {
								complete_function_calls = true,
								vtsls = {
									enableMoveToFileCodeAction = true,
									autoUseWorkspaceTsdk = true,
									experimental = {
										completion = {
											enableServerSideFuzzyMatch = true,
										},
									},
									globalPlugins = {
										{
											name = "@vue/typescript-plugin",
											location = get_pkg_path(
												"vue-language-server",
												"/node_modules/@vue/language-server"
											),
											languages = { "vue" },
											configNamespace = "typescript",
											enableForWorkspaceTypeScriptVersions = true,
										},
									},
								},
								typescript = {
									updateImportsOnFileMove = { enabled = "always" },
									suggest = {
										completeFunctionCalls = true,
									},
									inlayHints = {
										enumMemberValues = { enabled = true },
										functionLikeReturnTypes = { enabled = true },
										parameterNames = { enabled = "literals" },
										parameterTypes = { enabled = true },
										propertyDeclarationTypes = { enabled = true },
										variableTypes = { enabled = false },
									},
								},
							},
							keys = {
								{
									"gD",
									function()
										require("vtsls").commands.goto_source_definition(0)
									end,
									desc = "Goto Source Definition",
								},
								{
									"gR",
									function()
										require("vtsls").commands.file_references(0)
									end,
									desc = "File References",
								},
								{
									"<leader>co",
									function()
										require("vtsls").commands.organize_imports(0)
									end,
									desc = "Organize Imports",
								},
								{
									"<leader>cM",
									function()
										require("vtsls").commands.add_missing_imports(0)
									end,
									desc = "Add missing imports",
								},
								{
									"<leader>cu",
									function()
										require("vtsls").commands.remove_unused_imports(0)
									end,
									desc = "Remove unused imports",
								},
								{
									"<leader>cD",
									function()
										require("vtsls").commands.fix_all(0)
									end,
									desc = "Fix all diagnostics",
								},
								{
									"<leader>cV",
									function()
										require("vtsls").commands.select_ts_version(0)
									end,
									desc = "Select TS workspace version",
								},
							},
						})
					end,
				},
			})
		end,
	},

	-- vtsls, alternative to typescript-tools, shipped by lazyvim
	{
		"yioneko/nvim-vtsls",
		lazy = true,
		opts = {},
		config = function(_, opts)
			require("vtsls").config(opts)
		end,
	},

	-- tsserver plugin, better than normal lsp
	-- 	{
	-- 		"pmizio/typescript-tools.nvim",
	-- 		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	-- 		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 		opts = {},
	-- 	},
}

return M
