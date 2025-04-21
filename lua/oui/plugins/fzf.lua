return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	keys = {
		-- find files:
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
		{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },

		-- grepping:
		{ "<leader>fz", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Buffer" },
		{ "<leader>fq", "<cmd>FzfLua lgrep_quickfix<cr>", desc = "Grep Quickfix" },
		{ "<leader>fg", "<cmd>FzfLua live_grep_native<cr>", desc = "Grep directory" },

		-- session/lsp:
		{ "<leader>le", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
		{ "<leader>lE", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>lZ", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
		{ "<leader>lz", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "Workspace Symbols" },
		{ "<leader>lX", "<cmd>FzfLua lsp_code_actions<cr>", desc = "fzf finder" },

		{ "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
		{ "<leader>fQ", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>fr", "<cmd>FzfLua registers<cr>", desc = "Registers" },
		{ "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },

		-- git:
		{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
		{ "<leader>gC", "<cmd>FzfLua git_bcommits<CR>", desc = "Git Commits (buffer)" },
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },

		-- misc:
		{
			"<leader>S",
			"<cmd>lua require'fzf-lua'.spell_suggest({ winopts = {relative='cursor',row=1.01,col=0, height=0.2, width=0.2}})<cr>",
			desc = "Spell Suggestions",
		},
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>fp", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{ "<leader>fP", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
	},
	opts = {
		winopts = {
			row = 1,
			col = 0,
			height = 0.3,
			width = 1,
      backdrop = 70,
      border = "single",
      preview = {
        border = "single",
        flip_columns = 80,
      },
		},
	},
}
