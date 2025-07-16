local vue_ls_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_ls_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
  enableForWorkspaceTypeScriptVersions = true,
}

return {
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
          vue_plugin,
				},
			},
		},
	},
}
