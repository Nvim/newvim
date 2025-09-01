local M = {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Nextcloud/Obsidian/**/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Nextcloud/Obsidian/**/*.md",
  },
  cmd = {
    "Obsidian",
    "Obsidian open",
    "Obsidian new",
    "Obsidian new_from_template",
    "Obsidian search",
    "Obsidian quick_switch",
  },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>no", "<cmd>Obsidian <CR>", desc = "Obsidian Menu" },
		{ "<leader>nn", "<cmd>Obsidian new<CR>", desc = "New Note" },
		{ "<leader>nt", "<cmd>Obsidian new_from_template<CR>", desc = "New Note from Template" },
    { "<leader>nq", "<cmd>Obsidian open<CR>", desc = "Open in Obsidian App" },

		{ "<leader>nf", "<cmd>Obsidian quick_switch<CR>", desc = "Find note" },
    { "<leader>ng", "<cmd>Obsidian search<CR>", desc = "Grep notes"},
    { "<leader>nL", "<cmd>Obsidian backlinks<CR>", desc = "Get list of backlinks" },

    { "<leader>nd", "<cmd>Obsidian today<CR>", desc = "Daily - Today" },
    { "<leader>nD", "<cmd>Obsidian tomorrow<CR>", desc = "Daily - Tomorrow" },
    { "<leader>ny", "<cmd>Obsidian yesterday<CR>", desc = "Daily - Yesterday" },

		{ "<leader>nh", "<cmd>Obsidian link<CR>", desc = "Link selection to a note" },
		{ "<leader>nH", "<cmd>Obsidian link_new<CR>", desc = "Link selection to a new note" },
		{ "<leader>np", "<cmd>Obsidian paste_img<CR>", desc = "Paste image from clipboard" },
    { "<leader>nT", "<cmd>Obsidian template<CR>", desc = "Insert template" },

		{ "<leader>nr", "<cmd>Obsidian rename<CR>", desc = "Rename note" },
    { "<leader>ns", "<cmd>Obsidian toc<CR>", desc = "Table of contents" },
	},
	opts = {
    legacy_commands = false,
		ui = { enable = false },
		workspaces = {
			{
				name = "Obsidian",
				path = "~/Documents/Nextcloud/Obsidian",
			},
		},
		notes_subdir = "inbox",
		new_notes_location = "notes_subdir",
		disable_frontmatter = true,
		completion = {
			nvim_cmp = false,
      blink = true,
			min_chars = 2,
		},

    picker = {
      name = "fzf-lua",
    },

    callbacks = {
      enter_note = function(_, note)
        vim.o.cc = "80"
      end,
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%A %B %-d, %Y",
      default_tags = { "daily" },
      template = "daily.md",
      workdays_only = false,
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
