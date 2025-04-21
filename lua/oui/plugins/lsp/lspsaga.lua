-- lspsaga
return {
	"nvimdev/lspsaga.nvim",
	opts = {
		ui = {
			kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
		},
		code_action = {
			show_server_name = true,
		},
	},
	keys = {
		{ "<leader>ld", "<cmd>Lspsaga peek_definition<cr>", desc = "Lsp peek definition", silent = true },
		{ "<leader>lt", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Lsp peek type definition", silent = true },
		{ "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", desc = "Lsp hover doc", silent = true },
		{ "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "LSP code actions", silent = true },
		{ "<leader>lx", "<cmd>Lspsaga finder def+imp+ref<cr>", desc = "LSPSaga finder (float)", silent = true },
		{ "<leader>le", "<cmd>Lspsaga show_buf_diagnostics ++normal<cr>", desc = "LSPSaga buffer diagnostics", silent = true },
		{ "<leader>lE", "<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>", desc = "LSPSaga workspace diagnostics", silent = true },
		{ "<leader>lc", "<cmd>Lspsaga incoming_calls ++float<cr>", desc = "LSPSaga incoming calls (float)", silent = true },
		{ "<leader>lo", "<cmd>Lspsaga outgoing_calls ++float<cr>", desc = "LSPSaga outgoing calls (float)", silent = true },
		{ "<leader>ll", "<cmd>Lspsaga outline<cr>", desc = "LSPSaga outline", silent = true },

	},
  config = {
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        vim.keymap.del('n', 'K', { buffer = args.buf })
        -- vim.keymap.del('n', 'grn', { buffer = args.buf })
        -- vim.keymap.del('n', '[d', { buffer = args.buf })
        -- vim.keymap.del('n', ']d', { buffer = args.buf })
        --
        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { buffer = args.buf })
        vim.keymap.set('n', 'grn', '<cmd>Lspsaga rename<cr>', { buffer = args.buf })
        vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { buffer = args.buf })
        vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', { buffer = args.buf })
      end,
    })
  }
}
