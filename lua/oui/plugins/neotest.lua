return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"fredrikaverpil/neotest-golang", -- Installation
			dependencies = {
				"leoluz/nvim-dap-go",
			},
		},
	},
	keys = {

		{ "<leader>t", "", desc = "+test" },
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File (Neotest)",
		},
		{
			"<leader>tT",
			function()
				require("neotest").run.run(vim.uv.cwd())
			end,
			desc = "Run All Test Files (Neotest)",
		},
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run Nearest (Neotest)",
		},
		{
			"<leader>tl",
			function()
				require("neotest").run.run_last()
			end,
			desc = "Run Last (Neotest)",
		},
		{
			"<leader>tz",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary (Neotest)",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show Output (Neotest)",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Output Panel (Neotest)",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop (Neotest)",
		},
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle(vim.fn.expand("%"))
			end,
			desc = "Toggle Watch (Neotest)",
		},
	},
	config = function()
		local neotest_golang_opts = {} -- Specify custom configuration
		require("neotest").setup({
			adapters = {
				require("neotest-golang")(neotest_golang_opts), -- Registration
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
		})
	end,
}
