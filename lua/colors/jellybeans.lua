vim.pack.add({ "https://github.com/WTFox/jellybeans.nvim" })

require("jellybeans").setup({
	transparent = true,
	italics = true,
	bold = true,
	flat_ui = false, -- toggles "flat UI" for pickers
	background = {
		dark = "jellybeans_mono", -- "jellybeans" | "jellybeans_muted" | "jellybeans_mono"
		light = "jellybeans_mono_light", -- | "jellybeans_light" | "jellybeans_muted_light" | "jellybeans_mono_light 
	},
	plugins = {
		all = false,
		auto = true, -- auto-detect installed plugins via lazy.nvim
	},
	on_highlights = function(highlights, colors) end,
	on_colors = function(colors) end,
})

vim.cmd[[colorscheme jellybeans]]
