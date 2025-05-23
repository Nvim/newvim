return {
	"folke/tokyonight.nvim",
	lazy = true,
	-- priority = 1000,
	opts = {},
	config = function()
		require("tokyonight").setup({
			style = "storm", -- `storm`, `moon`, a darker variant `night` and `day`
			light_style = "day", -- The theme is used when the background is set to light
			transparent = true,
			terminal_colors = true,

			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},

			sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = false, -- dims inactive windows
			lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
