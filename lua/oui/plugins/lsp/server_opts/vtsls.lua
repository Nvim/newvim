local get_pkg_path = function(pkg, path, opts)
	pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
	opts = opts or {}
	opts.warn = opts.warn == nil and true or opts.warn
	path = path or ""
	local ret = root .. "/packages/" .. pkg .. "/" .. path
	---@diagnostic disable-next-line: empty-block
	if opts.warn and not vim.loop.fs_stat(ret) then
		-- TODO: do something
	end
	return ret
end

local M = {
	on_attach = function(_, bufnr)
		-- vim.keymap.del("n", "<leader>ld", { buffer = bufnr })
		vim.keymap.set(
			"n",
			"<leader>lF", -- TODO: override leader+ld
			"<cmd>VtsExec goto_source_definition<cr>",
			{ desc = "Go to Typescript source definition" }
		)
		vim.keymap.set("n", "<leader>lw", "<cmd>VtsExec file_references<cr>", { desc = "Typescript file references" })
		vim.keymap.set("n", "<leader>lI", "<cmd>VtsExec organize_imports<cr>", { desc = "Typescript Organize imports" })
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
						-- TODO: :h lspconfig-setup-hook
						-- location = "/home/naim/.npm-packages/lib/node_modules/@vue/language-server",
						location = get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
}

return M
