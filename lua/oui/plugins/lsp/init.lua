local M = {
	{
		"yioneko/nvim-vtsls",
		lazy = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		cond = function()
			return vim.bo.filetype ~= "java"
		end,
		dependencies = {
			"saghen/blink.cmp",
		},
	},
}

return M
