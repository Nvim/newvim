return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "windwp/nvim-ts-autotag" },
		},

		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter.configs")

			-- configure treesitter
			treesitter.setup({ -- enable syntax highlighting
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "latex" },
				},
				-- enable indentation
				indent = { enable = true, disable = { "python" } },
				-- enable autotagging (w/ nvim-ts-autotag plugin)
				autotag = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<M-space>",
						node_decremental = "<bs>",
					},

					-- ensure these language parsers are installed
					ensure_installed = {
						"c",
						"cpp",
						"java",
						"python",
						"javascript",
						"typescript",
						"html",
						"css",
						"lua",
						"tsx",
						"json",
						"yaml",
						"toml",
						"kdl",
						"bash",
						"vim",
						"dockerfile",
						"make",
						"gitignore",
						"markdown",
						"markdown_inline",
						"latex",
						"bibtex",
					},
				},
			})

			-- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
			-- require("ts_context_commentstring").setup({})
		end,
	},
}
