-- return {
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	config = function()
-- 		require("indent_blankline").setup({
-- 			char = "▏",
-- 			show_trailing_blankline_indent = false,
-- 			show_first_indent_level = false,
-- 			use_treesitter = true,
-- 			show_current_context = false,
-- 		})
-- 	end,
-- }
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = { char = "┊" },
			})
		end,
	},
}
