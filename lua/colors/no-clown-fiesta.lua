vim.pack.add({ "https://github.com/aktersnurra/no-clown-fiesta.nvim" })

require("no-clown-fiesta").setup({
	theme = "dark", -- supported themes are: dark, dim, light
	transparent = true, -- Enable this to disable the bg color
	-- styles = { -- You can set any of the style values specified for `:h nvim_set_hl`
	-- 	comments = {},
	-- 	functions = {},
	-- 	keywords = {},
	-- 	lsp = {},
	-- 	match_paren = {},
	-- 	type = {},
	-- 	variables = {},
	-- },
})
vim.cmd([[colorscheme no-clown-fiesta]])
