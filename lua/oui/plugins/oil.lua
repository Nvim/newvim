return {
	"stevearc/oil.nvim",
	opts = {
		float = {
			max_width = 80,
			max_height = 30,
			border = "rounded",
			win_options = {
				winblend = 0,
			},
		},
	},
	config = function(_, opts)
		require("oil").setup(opts)
		vim.keymap.set("n", "<leader>o", function()
			local oil = require("oil")
			oil.toggle_float()
		end, { desc = "Oil" })
	end,
}
