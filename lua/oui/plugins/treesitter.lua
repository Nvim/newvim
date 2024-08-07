return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
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

					textobjects = {
						swap = {
							enable = true,
							swap_next = { ["<leader>a"] = "@parameter.inner" },
							swap_previous = { ["<leader>A"] = "@parameter.inner" },
						},
						select = {
							enable = true,
							lookahead = true,

							keymaps = {
								["af"] = { query = "@function.outer", desc = "Outer function" },
								["if"] = { query = "@function.inner", desc = "Inner function" },
								["ac"] = { query = "@class.outer", desc = "Outer class" },
								["ic"] = { query = "@class.inner", desc = "Inner class" },
								["as"] = { query = "@scope", query_group = "locals", desc = "Scope" },
							},
							selection_modes = {
								["@parameter.outer"] = "v", -- charwise
								["@function.outer"] = "V", -- linewise
								["@class.outer"] = "<c-v>", -- blockwise
							},
							include_surrounding_whitespace = true,
						},
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
