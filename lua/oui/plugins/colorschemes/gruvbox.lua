-- return {
-- 	"morhetz/gruvbox",
-- 	priority = 1000,
-- 	config = function()
-- 		-- vim.g.gruvbox_transparent_bg = "0"
-- 		vim.g.gruvbox_contrast_dark = "medium"
-- 		vim.g.gruvbox_italic = "1"
-- 		vim.g.gruvbox_transparent_bg = "1"
--
-- 		-- not sure i want this:
-- 		-- vim.g.gruvbox_improved_strings = "1"
-- 		-- vim.g.gruvbox_improved_warnings = "1"
--
-- 		-- TODO: Custom colors for some ui elements, read docs
-- 		vim.cmd([[colorscheme gruvbox]])
-- 	end,
-- }

return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
