-- return {
-- 	"morhetz/gruvbox",
-- 	priority = 1000,
-- 	config = function()
-- 		-- vim.g.gruvbox_transparent_bg = "0"
-- 		vim.g.gruvbox_contrast_dark = "hard"
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

-- Normal gruvbox
-- return {
-- 	"ellisonleao/gruvbox.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("gruvbox").setup({
-- 			terminal_colors = true, -- add neovim terminal colors
-- 			undercurl = true,
-- 			underline = true,
-- 			bold = true,
-- 			italic = {
-- 				strings = true,
-- 				emphasis = true,
-- 				comments = true,
-- 				operators = false,
-- 				folds = true,
-- 			},
-- 			strikethrough = true,
-- 			invert_selection = false,
-- 			invert_signs = false,
-- 			invert_tabline = true,
-- 			invert_intend_guides = true,
-- 			inverse = true, -- invert background for search, diffs, statuslines and errors
-- 			contrast = "hard", -- can be "hard", "soft" or empty string
-- 			palette_overrides = {},
-- 			overrides = {},
-- 			dim_inactive = false,
-- 			transparent_mode = false,
-- 		})
-- 		vim.cmd("colorscheme gruvbox")
-- 	end,
-- }

-- Gruvbox baby:
return {
	"luisiacc/gruvbox-baby",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_baby_use_original_palette = 0 -- OG gruvbox
		vim.g.gruvbox_baby_background_color = "dark" -- sets background colors to None
		vim.g.gruvbox_baby_transparent_mode = 0 -- sets background colors to None
		vim.g.gruvbox_baby_function_style = "NONE"
		vim.g.gruvbox_baby_keyword_style = "italic"
		vim.g.gruvbox_baby_comment_style = "italic"
		vim.g.gruvbox_baby_string_style = "nocombine"
		vim.g.gruvbox_baby_variable_style = "NONE"
		vim.g.gruvbox_baby_color_overrides = {} -- override color palette with your custom colors

		-- vim.g.gruvbox_baby_telescope_theme = 1

		-- Each highlight group must follow the structure:
		-- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
		-- See also :h highlight-guifg
		-- Example:
		-- vim.g.gruvbox_baby_highlights = { Normal = { fg = "#123123", bg = "NONE", style = "underline" } }

		vim.cmd("colorscheme gruvbox-baby")
	end,
}
