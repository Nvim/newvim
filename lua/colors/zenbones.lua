vim.pack.add({
	"https://github.com/zenbones-theme/zenbones.nvim",
	"https://github.com/rktjmp/lush.nvim",
})

vim.g.zenbones_transparent_background = false
vim.g.zenbones_darkness = 'stark'
vim.cmd.colorscheme("zenbones")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
