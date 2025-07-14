return {
	"zenbones-theme/zenbones.nvim",
	dependencies = "rktjmp/lush.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.g.zenbones_darken_comments = 45
		vim.g.zenbones_transparent_background = true
		vim.g.zenwritten_transparent_background = true

		vim.g.zenwritten_lighten_cursor_line = 0
		vim.g.zenbones_lighten_cursor_line = 0
		vim.cmd.colorscheme("zenbones")

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

	end,
}
