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
		commit = "e7a4442e055ec953311e77791546238d1eaae507",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
		},
		event = "BufEnter",
		main = "ibl",
		config = function()
			require("ibl").setup({
				indent = {
					char = "▏",
					smart_indent_cap = true,
				},
				scope = { char = "▎" },
			})
		end,
	},
}
