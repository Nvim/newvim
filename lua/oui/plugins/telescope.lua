return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",

		-- TODO: get old settings back, configure pickers with docs (files, vim, git, TS)
		-- use different themes
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					-- Default configuration for telescope goes here:
					-- config_key = value,
					mappings = {
						i = {
							["<C-h>"] = "which_key",
						},
					},
				},
				pickers = {
					-- Default configuration for builtin pickers goes here:
					find_files = {
						theme = "ivy",
						layout_config = { height = 0.4 },
					},
					live_grep = {
						theme = "ivy",
						layout_config = { height = 0.4 },
					},
					buffers = {
						theme = "ivy",
						layout_config = { height = 0.4 },
					},
					treesitter = {
						theme = "ivy",
						layout_config = { height = 0.4 },
					},
					man_pages = {
						sections = { "1", "2", "3" },
						theme = "ivy",
						layout_config = { height = 0.4 },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					frecency = {
						auto_validate = false,
						matcher = "fuzzy",
						path_display = { "shorten" },
					},
				},
			})

			telescope.load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
}
