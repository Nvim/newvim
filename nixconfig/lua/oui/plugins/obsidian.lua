local M = {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>nq", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian App" },
		{ "<leader>nn", "<cmd>ObsidianNew<CR>", desc = "New Note" },
		{ "<leader>nt", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New Note from Template" },
		{ "<leader>nf", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find note" },
		{ "<leader>nl", "<cmd>ObsidianFollowLink<CR>", desc = "Follow Obsidian Link" },
		{ "<leader>nL", "<cmd>ObsidianBackLinks<CR>", desc = "Get list of backlinks" },
		{ "<leader>nT", "<cmd>ObsidianTemplate<CR>", desc = "Insert template" },
		{ "<leader>nh", "<cmd>ObsidianLink<CR>", desc = "Link selection to a note" },
		{ "<leader>nH", "<cmd>ObsidianLinkNew<CR>", desc = "Link selection to a new note" },
		{ "<leader>np", "<cmd>ObsidianPasteImg<CR>", desc = "Paste image from clipboard" },
		{ "<leader>nr", "<cmd>ObsidianRename --dry-run<CR>", desc = "Rename note" },
		{ "<leader>nc", "<cmd>ObsidianToggleCheckbox<CR>", desc = "Toggle checkbox" },
		{ "<leader>ns", "<cmd>ObsidianTOC<CR>", desc = "Table of contents" },
	},
	opts = {
		ui = { enable = false },
		workspaces = {
			{
				name = "Obsidian",
				path = "~/Documents/Sync/Obsidian",
			},
		},
		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",
		disable_frontmatter = true,
		completion = {
			nvim_cmp = false,
			min_chars = 2,
		},

		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		-- Optional, for templates (see below).
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M:%S",
		},

		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.date("%Y-%m-%d", os.time()) .. "_" .. suffix)
		end,

		-- Optional, customize how note file names are generated given the ID, target directory, and title.
		---@param spec { id: string, dir: obsidian.Path, title: string|? }
		---@return string|obsidian.Path The full path to the new note.
		note_path_func = function(spec)
			-- This is equivalent to the default behavior.
			local path = spec.dir / tostring(spec.id)
			return path:with_suffix(".md")
		end,
	},
}

return M
