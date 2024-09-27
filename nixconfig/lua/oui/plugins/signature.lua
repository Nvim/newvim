local M = {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
			toggle_key = "<c-g>",
			hint_prefix = {
				above = "↙ ", -- when the hint is on the line above the current line
				current = "← ", -- when the hint is on the same line
				below = "↖ ", -- when the hint is on the line below the current line
			},
		},
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}

return M
