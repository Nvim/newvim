return {
	"zenbones-theme/zenbones.nvim",
	dependencies = "rktjmp/lush.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.g.zenbones_darken_comments = 45
		vim.g.zenbones_transparent_background = false
    vim.g.zenbones_darkness = 'stark'

		vim.cmd.colorscheme("zenbones")

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

	end,
}
