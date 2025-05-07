return {
	"aktersnurra/no-clown-fiesta.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local plugin = require("no-clown-fiesta")
		plugin.setup({
			transparent = true,
			styles = {
				-- You can set any of the style values specified for `:h nvim_set_hl`
				comments = {
					italic = true,
				},
				functions = {},
				keywords = {},
				lsp = {
					underline = true,
				},
				match_paren = {
					underline = true,
				},
				type = {
					bold = true,
				},
				variables = {},
			},
		})
		return plugin.load()
	end,
}
