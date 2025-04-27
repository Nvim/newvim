local config = function()
	local lualine = require("lualine")

	-- configure lualine with modified theme
	lualine.setup({
		options = {
			-- theme = "black-metal",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			disabled_filetypes = {
				-- statusline = {
				-- 	"dapui_scopes",
				-- 	"dapui_breakpoints",
				-- 	"dapui_stacks",
				-- 	"dapui_watches",
				-- 	"dapui_console",
				-- 	"dap-repl",
				-- },
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { "lsp_status", "diagnostics" },
			lualine_x = { "overseer", "location" },
			lualine_y = { "filetype" },
			lualine_z = { "filename" },
		},
		extensions = { "fzf", "lazy", "man", "neo-tree", "nvim-dap-ui", "overseer", "quickfix" },
	})
end

local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- TODO: theme it
	config = config,
}

return M
